import 'package:get/get.dart';

import '../controllers/vendor_product_list_controller.dart';

class VendorProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorProductListController>(
      () => VendorProductListController(),
    );
  }
}
