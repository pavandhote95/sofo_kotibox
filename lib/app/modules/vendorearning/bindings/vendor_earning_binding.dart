import 'package:get/get.dart';

import '../controllers/vendor_earning_controller.dart';

class VendorEarningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorEarningController>(
      () => VendorEarningController(),
    );
  }
}
