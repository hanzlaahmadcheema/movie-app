import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserProfileRepository {
  UserProfileRepository._();

  static final UserProfileRepository instance = UserProfileRepository._();
  String? _lastUpsertedUid;

  FirebaseFirestore? get _firestore {
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseFirestore.instance;
  }

  void clearSession() => _lastUpsertedUid = null;

  Future<void> upsertProfile(User user, {bool force = false}) async {
    if (!force && _lastUpsertedUid == user.uid) {
      return;
    }
    final firestore = _firestore;
    if (firestore == null) {
      return Future<void>.value();
    }

    final providers =
        user.providerData
            .map((provider) => provider.providerId)
            .where((provider) => provider.isNotEmpty)
            .toSet()
            .toList()
          ..sort();
    final creationTime = user.metadata.creationTime;
    final doc = firestore.collection('users').doc(user.uid);
    final existing = await doc.get();
    final existingData = existing.data();

    await doc.set({
      'uid': user.uid,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'displayName': user.displayName,
      'photoUrl': user.photoURL,
      'emailVerified': user.emailVerified,
      'providers': providers,
      'role': (existingData?['role'] ?? 'user').toString(),
      'status': (existingData?['status'] ?? 'active').toString(),
      if (creationTime != null && existingData?['createdAt'] == null)
        'createdAt': Timestamp.fromDate(creationTime),
      'lastLoginAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    _lastUpsertedUid = user.uid;
  }
}
