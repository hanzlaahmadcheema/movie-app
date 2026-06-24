import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../services/auth_service.dart';
import 'current_user_role.dart';

class UserRoleService {
  UserRoleService({FirebaseFirestore? firestore}) : _firestoreOverride = firestore;

  static UserRoleService instance = UserRoleService();

  final FirebaseFirestore? _firestoreOverride;

  FirebaseFirestore? get _firestore {
    if (_firestoreOverride != null) {
      return _firestoreOverride;
    }
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseFirestore.instance;
  }

  Stream<CurrentUserRole> watchCurrentUserRole() async* {
    await for (final user in AuthService.instance.authStateChanges) {
      if (user == null || _firestore == null) {
        yield const CurrentUserRole.signedOut();
        continue;
      }
      yield* watchRole(user);
    }
  }

  Stream<CurrentUserRole> watchRole(User user) {
    final firestore = _firestore;
    if (firestore == null) {
      return Stream<CurrentUserRole>.value(
        CurrentUserRole.fromJson(user.uid, const {}),
      );
    }
    return firestore.collection('users').doc(user.uid).snapshots().map(
      (snapshot) => CurrentUserRole.fromJson(user.uid, snapshot.data()),
    );
  }

  Future<CurrentUserRole> loadRole(User? user) async {
    if (user == null || _firestore == null) {
      return const CurrentUserRole.signedOut();
    }
    final snapshot = await _firestore!.collection('users').doc(user.uid).get();
    return CurrentUserRole.fromJson(user.uid, snapshot.data());
  }
}

