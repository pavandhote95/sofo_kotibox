import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var allOrders = <Map<String, dynamic>>[].obs;

  final String apiUrl =
      "http://kotiboxglobaltech.com/sofo_app/api/vendor/received-order-list";

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      // ✅ Get token from storage
      final box = GetStorage();
      String? token = box.read("token");

      var headers = {
        "Authorization": "Bearer $token",
      };

      var response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData["status"] == true) {
          List data = jsonData["data"];
          allOrders.value = data.map((e) {
            return {
              "orderId": e["order_id"].toString(),
              "tracking": e["order_number"].toString(),
              "quantity": e["quantity"].toString(),
              "amount": e["total_amount"].toString(),
              "status": e["status"].toString(),
              "date": e["created_at"].toString(),
            };
          }).toList();
        }
      } else {
        Get.snackbar("Error", "Failed to fetch orders");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
