import 'dart:convert';

import 'package:get/get.dart';
import 'package:sofo/app/services/api_service.dart';

class ShopProductsController extends GetxController {
  //TODO: Implement ShopProductsController
  final int storeId;
  final String shopName;

  ShopProductsController(this.storeId, this.shopName);

  var isLoading = false.obs;
  var productList = [].obs;

  final RestApi _api = RestApi();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
Future<void> fetchProducts() async {
  try {
    isLoading(true);
    final url =
        "https://kotiboxglobaltech.com/sofo_app/api/store/store-item/10";

    print("📡 API URL CALLED: $url");   // URL log

    final response = await _api.getApi(url);

    print("📥 RAW RESPONSE: ${response.body}");   // पूरा raw response log

    var data = json.decode(response.body);

    print("📦 DECODED RESPONSE: $data");  // decoded map log

    if (data["data"] != null) {
      productList.value = data["data"];

      print("✅ TOTAL PRODUCTS: ${productList.length}");
      for (var product in productList) {
        print("➡️ PRODUCT ITEM: $product");
      }
    } else {
      productList.clear();
      print("⚠️ NO PRODUCTS FOUND in API response");
    }
  } catch (e) {
    productList.clear();
    print("❌ ERROR fetching products: $e");
  } finally {
    isLoading(false);
  }
}
}