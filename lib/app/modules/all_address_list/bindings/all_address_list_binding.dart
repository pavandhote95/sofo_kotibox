import 'package:get/get.dart';

import '../controllers/all_address_list_controller.dart';

class AllAddressListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllAddressListController>(
      () => AllAddressListController(),
    );
  }
}
