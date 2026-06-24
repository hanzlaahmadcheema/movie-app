import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/auth/current_user_role.dart';

void main() {
  test('missing role defaults to user', () {
    final role = CurrentUserRole.fromJson('uid-1', const {});

    expect(role.uid, 'uid-1');
    expect(role.role, UserRoleValue.user);
    expect(role.status, UserAccountStatus.active);
    expect(role.isAdmin, isFalse);
  });

  test('admin role enables admin state', () {
    final role = CurrentUserRole.fromJson('uid-2', const {'role': 'admin'});

    expect(role.role, UserRoleValue.admin);
    expect(role.isAdmin, isTrue);
    expect(role.isSuperAdmin, isFalse);
  });

  test('blocked status is parsed', () {
    final role = CurrentUserRole.fromJson('uid-3', const {'status': 'blocked'});

    expect(role.status, UserAccountStatus.blocked);
    expect(role.isBlocked, isTrue);
  });
}
