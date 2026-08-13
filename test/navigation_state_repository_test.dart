import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/app_routes.dart';
import 'package:movie_app/core/auth/current_user_role.dart';
import 'package:movie_app/core/navigation/navigation_state_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<NavigationStateRepository> createRepository() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return NavigationStateRepository(
      preferences: prefs,
    );
  }

  test('always opens home screen on restore target', () async {
    final repository = await createRepository();

    final target = await repository.buildRestoreTarget(
      role: const CurrentUserRole(
        uid: 'u1',
        role: UserRoleValue.user,
        status: UserAccountStatus.active,
        isVerified: true,
      ),
    );

    expect(target.route, AppRoutes.home);
    expect(target.arguments, isNull);
  });

  test('loadState always returns null when disabled', () async {
    final repository = await createRepository();
    final state = await repository.loadState();
    expect(state, isNull);
  });
}
