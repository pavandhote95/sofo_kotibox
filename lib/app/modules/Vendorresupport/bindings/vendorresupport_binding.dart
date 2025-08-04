import 'package:get/get.dart';

import '../controllers/vendorresupport_controller.dart';

class VendorresupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorresupportController>(
      () => VendorresupportController(),
    );
  }
}
