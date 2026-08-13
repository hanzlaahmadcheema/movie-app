import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../services/auth_service.dart';
import 'current_user_role.dart';

class _RoleCacheEntry {
  _RoleCacheEntry({required this.role, required this.timestamp});
  final CurrentUserRole role;
  final DateTime timestamp;

  bool get isExpired =>
      DateTime.now().difference(timestamp) > const Duration(minutes: 5);
}

class UserRoleService {
  UserRoleService({FirebaseFirestore? firestore}) : _firestoreOverride = firestore;

  static UserRoleService instance = UserRoleService();

  final FirebaseFirestore? _firestoreOverride;
  final Map<String, _RoleCacheEntry> _roleCache = {};

  FirebaseFirestore? get _firestore {
    if (_firestoreOverride != null) {
      return _firestoreOverride;
    }
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseFirestore.instance;
  }

  void clearCache() => _roleCache.clear();

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
      (snapshot) {
        final role = CurrentUserRole.fromJson(user.uid, snapshot.data());
        _roleCache[user.uid] = _RoleCacheEntry(role: role, timestamp: DateTime.now());
        return role;
      },
    );
  }

  Future<CurrentUserRole> loadRole(User? user, {bool forceRefresh = false}) async {
    if (user == null || _firestore == null) {
      return const CurrentUserRole.signedOut();
    }
    final cached = _roleCache[user.uid];
    if (!forceRefresh && cached != null && !cached.isExpired) {
      return cached.role;
    }
    final snapshot = await _firestore!.collection('users').doc(user.uid).get();
    final role = CurrentUserRole.fromJson(user.uid, snapshot.data());
    _roleCache[user.uid] = _RoleCacheEntry(role: role, timestamp: DateTime.now());
    return role;
  }
}

