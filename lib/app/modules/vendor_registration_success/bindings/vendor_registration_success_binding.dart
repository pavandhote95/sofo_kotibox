import 'package:get/get.dart';

import '../controllers/vendor_registration_success_controller.dart';

class VendorRegistrationSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorRegistrationSuccessController>(
      () => VendorRegistrationSuccessController(),
    );
  }
}
