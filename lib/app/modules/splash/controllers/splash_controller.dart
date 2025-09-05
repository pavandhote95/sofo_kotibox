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

<<<<<<< HEAD
    final bool hasSeenOnboarding = box.read('seen_onboarding') ?? false;
    final bool isLoggedIn = box.read('isLogin') ?? false;
=======
    final hasSeenOnboarding = box.read('seen_onboarding') ?? false;
    final isLoggedIn = box.read('isLogin') ?? false;
    final token = box.read('token') ?? '';
>>>>>>> 27d6f4b26400c38ef0b406ab722b1401c744bb63

    if (!hasSeenOnboarding) {
      // ✅ Save that onboarding has been shown
      await box.write('seen_onboarding', true);
      Get.offAllNamed(Routes.ONBOARDING);
    } else if (isLoggedIn) {
      // ✅ Token / login state available
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
<<<<<<< HEAD

      // ✅ Not logged in
      Get.offAllNamed(Routes.LOGIN);

      if (isLoggedIn) {
      Get.offAllNamed(Routes.ONBOARDING);
=======
      // ✅ check both login & token
      if (isLoggedIn && token.isNotEmpty) {
        Get.offAllNamed(Routes.DASHBOARD);
>>>>>>> 27d6f4b26400c38ef0b406ab722b1401c744bb63
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }

    }
  }
}
