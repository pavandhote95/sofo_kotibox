import 'package:get/get.dart';

import '../controllers/vendoradditem_controller.dart';

class VendoradditemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendoradditemController>(
      () => VendoradditemController(),
    );
  }
}
