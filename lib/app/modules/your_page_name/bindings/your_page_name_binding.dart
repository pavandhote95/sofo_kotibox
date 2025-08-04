import 'package:get/get.dart';

import '../controllers/your_page_name_controller.dart';

class YourPageNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YourPageNameController>(
      () => YourPageNameController(),
    );
  }
}
