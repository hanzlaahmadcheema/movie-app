enum UserRoleValue { user, admin, superAdmin }

enum UserAccountStatus { active, blocked }

class CurrentUserRole {
  const CurrentUserRole({
    required this.uid,
    required this.role,
    required this.status,
    required this.isVerified,
  });

  const CurrentUserRole.signedOut()
    : uid = '',
      role = UserRoleValue.user,
      status = UserAccountStatus.active,
      isVerified = false;

  final String uid;
  final UserRoleValue role;
  final UserAccountStatus status;
  final bool isVerified;

  bool get isSignedIn => uid.trim().isNotEmpty;
  bool get isAdmin => role == UserRoleValue.admin || role == UserRoleValue.superAdmin;
  bool get isSuperAdmin => role == UserRoleValue.superAdmin;
  bool get isBlocked => status == UserAccountStatus.blocked;

  String get roleName => switch (role) {
    UserRoleValue.user => 'user',
    UserRoleValue.admin => 'admin',
    UserRoleValue.superAdmin => 'super_admin',
  };

  String get statusName => switch (status) {
    UserAccountStatus.active => 'active',
    UserAccountStatus.blocked => 'blocked',
  };

  factory CurrentUserRole.fromJson(String uid, Map<String, dynamic>? json) {
    final roleValue = (json?['role'] ?? 'user').toString().trim().toLowerCase();
    final statusValue = (json?['status'] ?? 'active')
        .toString()
        .trim()
        .toLowerCase();
    final role = switch (roleValue) {
      'admin' => UserRoleValue.admin,
      'super_admin' => UserRoleValue.superAdmin,
      _ => UserRoleValue.user,
    };
    final isAdminOrSuper = role == UserRoleValue.admin || role == UserRoleValue.superAdmin;
    return CurrentUserRole(
      uid: uid,
      role: role,
      status: switch (statusValue) {
        'blocked' => UserAccountStatus.blocked,
        _ => UserAccountStatus.active,
      },
      isVerified: isAdminOrSuper || json?['isVerified'] == true || json?['verified'] == true,
    );
  }
}

