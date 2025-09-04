import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasSeenOnboarding = box.read('seen_onboarding') ?? false;
    final isLoggedIn = box.read('isLogin') ?? false;
    final token = box.read('token') ?? '';

    if (!hasSeenOnboarding) {
      box.write('seen_onboarding', true);
      Get.offAllNamed(Routes.ONBOARDING);
    } else {
      // ✅ check both login & token
      if (isLoggedIn && token.isNotEmpty) {
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }
}
