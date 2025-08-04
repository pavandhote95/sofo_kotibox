import 'package:get/get.dart';

import '../controllers/vendor_customers_controller.dart';

class VendorCustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(
      () => CustomersController(),
    );
  }
}
