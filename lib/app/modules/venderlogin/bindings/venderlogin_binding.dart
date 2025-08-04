import 'package:get/get.dart';

import '../controllers/venderlogin_controller.dart';

class VenderRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorRegisterController>(
      () => VendorRegisterController(),
    );
  }
}
