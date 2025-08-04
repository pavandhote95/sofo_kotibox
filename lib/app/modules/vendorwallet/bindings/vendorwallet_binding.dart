import 'package:get/get.dart';

import '../controllers/vendorwallet_controller.dart';

class VendorwalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(
      () => WalletController(),
    );
  }
}
