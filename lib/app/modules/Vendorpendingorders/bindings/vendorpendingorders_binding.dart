import 'package:get/get.dart';

import '../controllers/vendorpendingorders_controller.dart';

class VendorpendingordersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorPendingOrderController>(
      () => VendorPendingOrderController(),
    );
  }
}
