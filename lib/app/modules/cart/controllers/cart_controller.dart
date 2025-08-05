import 'dart:convert';
import 'package:get/get.dart';
import '../../../custom_widgets/api_url.dart';
import '../../../services/api_service.dart';
import '../../checkout/views/checkout_view.dart';

class CartController extends GetxController {
  final api = RestApi();

  final cartItems = <Map<String, dynamic>>[].obs;
  final quantities = <int>[].obs;
  final shippingFee = 0.0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }


  void sendData({required int Id,required int productId, required int quantity}) async {
    try {
      final response = await api.postWithToken(
        AddQty,
        {
          "cart_id": Id,
          "product_id": productId,
          "quantity": quantity,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Product added to cart");
        // Get.toNamed('/dashboard');
      } else {
        Get.snackbar("Error", "Failed to add to cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
    }
  }

    Future<void> fetchCartItems() async {
    isLoading.value = true;
    try {
      final response = await api.getWithAuthApi(gettocartlist);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Cart API Response: $responseData");
        if (responseData['status'] == true) {
          final items = List<Map<String, dynamic>>.from(responseData['items'] ?? []);
          cartItems.assignAll(items);

          quantities.assignAll(items.map<int>((e) => e['quantity'] ?? 1).toList());

          final fee = responseData['shipping_fee'];

          shippingFee.value = (fee is int || fee is double)
              ? fee.toDouble()
              : double.tryParse(fee.toString()) ?? 0.0;
        } else {
          Get.snackbar("Error", "Invalid cart response");
        }
      } else {
        Get.snackbar("Error", "Failed to load cart: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCartItem(int index, dynamic itemId) async {
    try {
      final response = await api.deleteApiWithAuth("${deletecartlist}$itemId", "");
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
    double total = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      final price = double.tryParse(cartItems[i]['product_price'].toString()) ?? 0.0;
      total += price * quantities[i];
    }
    return total;
  }

  double get totalPrice => totalItemPrice + shippingFee.value;

  void increment(int index) {
    quantities[index]++;
    print(quantities[index],);
    sendData(
      productId: cartItems[index]['product_id'],
      Id:  cartItems[index]['id'],
      quantity: quantities[index],
    );
  }

  void decrement(int index) {
    if (quantities[index] > 1) {
      quantities[index]--;
      print(quantities[index],);

      sendData(
        productId: cartItems[index]['product_id'],
        Id:  cartItems[index]['id'],

        quantity: quantities[index],
      );
    }
  }

  void checkout() {
    final total = totalPrice;
    final productIds = cartItems.map<int>((item) => item['product_id']).toList();

    Get.to(
          () => CheckoutView(
        totalPrice: total,
        productIds: productIds,
      ),
    );
  }

}
