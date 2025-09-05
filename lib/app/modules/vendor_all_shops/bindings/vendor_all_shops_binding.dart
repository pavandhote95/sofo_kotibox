import 'package:get/get.dart';

import '../controllers/vendor_all_shops_controller.dart';

class VendorAllShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorAllShopsController>(
      () => VendorAllShopsController(),
    );
  }
}
