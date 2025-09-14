import 'package:get/get.dart';

import '../controllers/choose_deliverydatetime_controller.dart';

class ChooseDeliverydatetimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseDeliverydatetimeController>(
      () => ChooseDeliverydatetimeController(),
    );
  }
}
