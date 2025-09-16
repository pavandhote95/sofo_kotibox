import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var allOrders = <Map<String, dynamic>>[].obs;

  final String apiUrl =
      "http://kotiboxglobaltech.com/sofo_app/api/user/order-list";

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      final token = storage.read("token") ?? "";
      if (token.isEmpty) {
        print("⚠️ Token not found!");
        allOrders.value = [];
        return;
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true && data['data'] is List) {
          allOrders.value = List<Map<String, dynamic>>.from(
            data['data'].map((e) {
              // ✅ Calculate total quantity
              int totalQty = 0;
              if (e["items"] != null) {
                for (var item in e["items"]) {
                  totalQty += int.tryParse(item["quantity"].toString()) ?? 0;
                }
              }

              return {
                "orderId": e["order_id"],
                "tracking": e["order_number"],
                "amount": e["grand_total"],
                "status": e["order_status"],
                "date": e["created_at"],
                "deliveryType": e["delivery_type"],
                "selectedDate": e["selected_date"],
                "selectedTime": e["selected_time"],
                "items": e["items"] ?? [],
                "quantity": totalQty, // ✅ Added
              };
            }),
          );
        } else {
          allOrders.value = [];
        }
      } else {
        print("⚠️ API Error: ${response.statusCode}");
        allOrders.value = [];
      }
    } catch (e) {
      print("❌ Error fetching orders: $e");
      allOrders.value = [];
    } finally {
      isLoading.value = false;
    }
  }
}
