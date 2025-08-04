import 'package:get/get.dart';

import '../controllers/vendorallorders_controller.dart';

class VendorallordersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorAllOrderController>(
      () => VendorAllOrderController(),
    );
  }
}
