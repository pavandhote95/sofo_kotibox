import 'package:get/get.dart';

import '../controllers/vendorreview_controller.dart';

class VendorreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewsController>(
      () => ReviewsController(),
    );
  }
}
