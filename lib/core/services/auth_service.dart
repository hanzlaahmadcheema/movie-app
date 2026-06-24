import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'user_profile_repository.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final _googleSignIn = GoogleSignIn.instance;
  Future<void>? _googleInit;

  FirebaseAuth? get _auth {
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseAuth.instance;
  }

  User? get currentUser => _auth?.currentUser;

  Stream<User?> get authStateChanges =>
      _auth?.authStateChanges() ?? Stream<User?>.value(null);

  Stream<User?> get userChanges =>
      _auth?.userChanges() ?? Stream<User?>.value(null);

  Future<void> initializeGoogleSignIn() {
    return _googleInit ??= _googleSignIn.initialize();
  }

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await _requireAuth().signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      await UserProfileRepository.instance.upsertProfile(user);
    }
    return userCredential;
  }

  Future<UserCredential> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _requireAuth().createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user;
    if (user != null) {
      await user.updateDisplayName(name.trim());
      await user.reload();
      await UserProfileRepository.instance.upsertProfile(
        _requireAuth().currentUser ?? user,
      );
    }
    return credential;
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _requireAuth().sendPasswordResetEmail(email: email.trim());
  }

  Future<void> updateProfile({
    required String displayName,
    required String photoUrl,
  }) async {
    final user = currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'requires-login',
        message: 'Login is required to update your profile.',
      );
    }

    await user.updateDisplayName(displayName.trim());
    await user.updatePhotoURL(photoUrl.trim().isEmpty ? null : photoUrl.trim());
    await user.reload();
    final refreshedUser = _requireAuth().currentUser;
    if (refreshedUser != null) {
      await UserProfileRepository.instance.upsertProfile(refreshedUser);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = currentUser;
    final email = user?.email;
    final hasPasswordProvider =
        user?.providerData.any(
          (provider) => provider.providerId == EmailAuthProvider.PROVIDER_ID,
        ) ==
        true;
    if (user == null || email == null || !hasPasswordProvider) {
      throw FirebaseAuthException(
        code: 'password-change-unavailable',
        message: 'Password changes are available for email accounts only.',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  Future<void> addPassword({required String newPassword}) async {
    final user = currentUser;
    final email = user?.email;
    if (user == null || email == null || email.isEmpty) {
      throw FirebaseAuthException(
        code: 'password-link-unavailable',
        message: 'An email address is required to add a password.',
      );
    }

    final hasPasswordProvider = user.providerData.any(
      (provider) => provider.providerId == EmailAuthProvider.PROVIDER_ID,
    );
    if (hasPasswordProvider) {
      throw FirebaseAuthException(
        code: 'provider-already-linked',
        message: 'A password is already linked to this account.',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: newPassword,
    );
    await user.linkWithCredential(credential);
    await _refreshAndSyncProfile(user);
  }

  Future<UserCredential> signInWithGoogle() async {
    await initializeGoogleSignIn();
    if (!_googleSignIn.supportsAuthenticate()) {
      throw FirebaseAuthException(
        code: 'google-sign-in-unavailable',
        message: 'Google sign-in is not available on this platform.',
      );
    }

    final googleUser = await _googleSignIn.authenticate();
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw FirebaseAuthException(
        code: 'missing-google-id-token',
        message: 'Google sign-in did not return an ID token.',
      );
    }

    final credential = GoogleAuthProvider.credential(idToken: idToken);
    final userCredential = await _requireAuth().signInWithCredential(
      credential,
    );
    final user = userCredential.user;
    if (user != null) {
      await UserProfileRepository.instance.upsertProfile(user);
    }
    return userCredential;
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) {
    return _requireAuth().verifyPhoneNumber(
      phoneNumber: phoneNumber.trim(),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      forceResendingToken: forceResendingToken,
    );
  }

  Future<UserCredential> signInWithPhoneCredential(
    PhoneAuthCredential credential,
  ) async {
    final userCredential = await _requireAuth().signInWithCredential(
      credential,
    );
    final user = userCredential.user;
    if (user != null) {
      await UserProfileRepository.instance.upsertProfile(user);
    }
    return userCredential;
  }

  Future<UserCredential> signInWithPhoneCode({
    required String verificationId,
    required String smsCode,
  }) {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode.trim(),
    );
    return signInWithPhoneCredential(credential);
  }

  Future<UserCredential> linkPhoneCredential(
    PhoneAuthCredential credential,
  ) async {
    final user = currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'requires-login',
        message: 'Login is required to add a phone number.',
      );
    }

    final result = await user.linkWithCredential(credential);
    await _refreshAndSyncProfile(result.user ?? user);
    return result;
  }

  Future<UserCredential> linkPhoneCode({
    required String verificationId,
    required String smsCode,
  }) {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode.trim(),
    );
    return linkPhoneCredential(credential);
  }

  Future<void> signOut() async {
    await _auth?.signOut();
    if (_googleInit != null) {
      await _googleSignIn.signOut();
    }
  }

  Future<void> _refreshAndSyncProfile(User fallbackUser) async {
    await fallbackUser.reload();
    await UserProfileRepository.instance.upsertProfile(
      _requireAuth().currentUser ?? fallbackUser,
    );
  }

  FirebaseAuth _requireAuth() {
    final auth = _auth;
    if (auth == null) {
      throw FirebaseAuthException(
        code: 'firebase-not-initialized',
        message: 'Firebase has not been initialized.',
      );
    }
    return auth;
  }
}
