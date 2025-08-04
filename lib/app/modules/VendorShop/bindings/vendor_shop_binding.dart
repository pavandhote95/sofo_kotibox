import 'package:get/get.dart';

import '../controllers/vendor_shop_controller.dart';

class VendorShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorShopController>(
      () => VendorShopController(),
    );
  }
}
