import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/custom_widgets/snacbar.dart';
import '../../../../custom_widgets/api_url.dart';
import '../../../../services/api_service.dart';
import '../../../Dashboard/controllers/dashboard_controller.dart';

class ProductDetailsController extends GetxController {
  var quantity = 1.obs;
  var pricePerItem = 0.0.obs;
  var isLoading = false.obs;

  final api = RestApi();
  final storage = GetStorage(); // ✅ GetStorage instance

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

  /// Save product ID to storage
  void saveProductId(int productId) {
    storage.write('last_product_id', productId);
  }

  /// Retrieve product ID from storage
  int? getSavedProductId() {
    return storage.read('last_product_id');
  }

  Future<void> sendData({required int productId}) async {
    isLoading.value = true;
    saveProductId(productId); // ✅ Save ID before API call

    try {
      final response = await api.postWithToken(
        Addtocart,
        {
          "product_id": productId,
          "quantity": quantity.value, // ✅ Dynamic quantity
        },
      );

      if (response.statusCode == 200) {
        Utils.showToast("Product added to cart");

        // ✅ Navigate to Dashboard -> Cart tab with arguments
        Get.offAllNamed('/dashboard', arguments: {
          "productId": productId,
          "quantity": quantity.value,
        });

        // Change to Cart tab
        Future.delayed(const Duration(milliseconds: 200), () {
          Get.find<DashboardController>().changeIndex(0);
        });
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
