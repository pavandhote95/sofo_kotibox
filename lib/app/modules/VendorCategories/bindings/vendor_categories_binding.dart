import 'package:get/get.dart';

import '../controllers/vendor_categories_controller.dart';

class VendorCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorCategoriesController>(
      () => VendorCategoriesController(),
    );
  }
}
