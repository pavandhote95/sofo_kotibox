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

    final bool hasSeenOnboarding = box.read('seen_onboarding') ?? false;
    final bool isLoggedIn = box.read('isLogin') ?? false;

    if (!hasSeenOnboarding) {
      // ✅ Save that onboarding has been shown
      await box.write('seen_onboarding', true);
      Get.offAllNamed(Routes.ONBOARDING);
    } else if (isLoggedIn) {
      // ✅ Token / login state available
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      // ✅ Not logged in
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
