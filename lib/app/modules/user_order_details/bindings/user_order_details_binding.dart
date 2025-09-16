import 'package:get/get.dart';

import '../controllers/user_order_details_controller.dart';

class UserOrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserOrderDetailsController>(
      () => UserOrderDetailsController(),
    );
  }
}
