import 'dart:convert';
import 'package:get/get.dart';
import '../../../custom_widgets/api_url.dart';
import '../../../services/api_service.dart';

class CartController extends GetxController {
  final api = RestApi();

  final cartItems = <Map<String, dynamic>>[].obs;
  final quantities = <int>[].obs;
  final shippingFee = 60.0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    isLoading.value = true;

    try {
      final response = await api.getWithAuthApi(gettocartlist);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        cartItems.assignAll(data.map((e) => e as Map<String, dynamic>).toList());
        quantities.assignAll(data.map<int>((e) => e['quantity'] ?? 1).toList());
      } else {
        Get.snackbar("Error", "Failed to load cart: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCartItem(int index, dynamic itemid) async {
    try {
      final response = await api.deleteApiWithAuth("${deletecartlist}$itemid", "");
      if (response.statusCode == 200 || response.statusCode == 204) {
        cartItems.removeAt(index);
        quantities.removeAt(index);
        Get.snackbar("Success", "Item removed from cart");
      } else {
        Get.snackbar("Error", "Failed to delete item: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  double get totalItemPrice {
    double total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      final price = double.tryParse(cartItems[i]['product_price'].toString()) ?? 0.0;
      total += price * quantities[i];
    }
    return total;
  }

  double get totalPrice => totalItemPrice + shippingFee.value;

  void increment(int index) => quantities[index]++;

  void decrement(int index) {
    if (quantities[index] > 1) {
      quantities[index]--;
    }
  }

  void checkout() {
    print("Checking out with total ₹${totalPrice.toStringAsFixed(2)}");
  }
}