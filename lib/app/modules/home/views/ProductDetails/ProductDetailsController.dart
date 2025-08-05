import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/snacbar.dart';

import '../../../../custom_widgets/api_url.dart';
import '../../../../services/api_service.dart';

class ProductDetailsController extends GetxController {
  var quantity = 1.obs;
  var pricePerItem = 0.0.obs;
  var isLoading = false.obs;

  void setInitialPrice(String priceString) {
    pricePerItem.value = double.tryParse(priceString) ?? 0.0;
  }

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  double get totalPrice => quantity.value * pricePerItem.value;

  final api = RestApi();

  void sendData({required int productId, required int quantity}) async {
    isLoading.value = true;
    try {
      final response = await api.postWithToken(
        Addtocart,
        {
          "product_id": productId,
          "quantity": quantity,
        },
      );

      if (response.statusCode == 200) {
  Utils.showToast("Product added to cart");

        print("heloo");
        Get.toNamed('/dashboard');
      } else {
        Get.snackbar("Error", "Failed to add to cart");
      }
    } catch (e) {





      
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
