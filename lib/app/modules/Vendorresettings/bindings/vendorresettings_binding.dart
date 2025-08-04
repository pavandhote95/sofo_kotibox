import 'package:get/get.dart';

import '../controllers/vendorresettings_controller.dart';

class VendorresettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
