import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class UserOrderDetailsController extends GetxController {
  var isLoading = false.obs;
  var orderDetails = {}.obs;
  var items = [].obs; // ✅ Store items separately for easy UI binding

  final String apiUrl =
      "http://kotiboxglobaltech.com/sofo_app/api/user/order-details";

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['orderId'] != null) {
      fetchOrderDetails(args['orderId'].toString());
    }
  }

  Future<void> fetchOrderDetails(String orderId) async {
    try {
      isLoading.value = true;

      final box = GetStorage();
      String? token = box.read("token");

      print("📦 Fetching details for order_id=$orderId");
      print("🔑 Token: $token");
      print("🌍 API URL: $apiUrl?order_id=$orderId");

      var response = await http.get(
        Uri.parse("$apiUrl?order_id=$orderId"),
        headers: {"Authorization": "Bearer $token"},
      );

      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData["status"] == true &&
            jsonData["data"] != null &&
            jsonData["data"] is List &&
            jsonData["data"].isNotEmpty) {
          var order = jsonData["data"][0]; // ✅ Take first order
          orderDetails.value = order;
          items.value = order["items"] ?? [];
        } else {
          Get.snackbar("Error", "Order not found or invalid response");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch order details");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
