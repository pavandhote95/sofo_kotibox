import 'package:get/get.dart';
import '../controllers/shop_products_controller.dart';

class ShopProductsBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;

    Get.lazyPut<ShopProductsController>(
      () => ShopProductsController(
        args["storeId"],
        args["shopName"],
      ),
    );
  }
}
