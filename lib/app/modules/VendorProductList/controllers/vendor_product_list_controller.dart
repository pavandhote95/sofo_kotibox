// vendor_product_controller.dart

import 'package:get/get.dart';

class VendorProductListController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialProducts();
  }

  void loadInitialProducts() {
    products.assignAll([
      {
        'image':
        'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/airpods-max-select-202409-blue_FV1?wid=976&hei=916&fmt=jpeg&qlt=90',
        'name': 'Wireless Headphones',
        'description': 'High quality sound with noise cancellation.',
        'price': 1999,
        'quantity': 10,
        'category': 'Electronics',
      },
      {
        'image':
        'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/airpods-max-select-202409-blue_FV1?wid=976&hei=916&fmt=jpeg&qlt=90',
        'name': 'Wooden Chair',
        'description': 'Ergonomic and durable wooden chair.',
        'price': 1200,
        'quantity': 5,
        'category': 'Furniture',
      },
      {
        'image':
        'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/airpods-max-select-202409-blue_FV1?wid=976&hei=916&fmt=jpeg&qlt=90',
        'name': 'T-Shirt',
        'description': '100% cotton comfortable t-shirt.',
        'price': 499,
        'quantity': 20,
        'category': 'Clothing',
      },
    ]);
  }

  void deleteProduct(int index) {
    products.removeAt(index);
  }
}
