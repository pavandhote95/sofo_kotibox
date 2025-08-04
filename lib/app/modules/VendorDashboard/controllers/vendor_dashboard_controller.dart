import 'package:get/get.dart';

class VendorDashboardController extends GetxController {
  late RxString userid;

  @override
  void onInit() {
    super.onInit();
    // Fetch userid from arguments or manually set
    userid = Get.arguments?['userid'] ?? ''.obs;
    print("VendorDashboardController initialized. User ID: ${userid.value}");
  }
}
