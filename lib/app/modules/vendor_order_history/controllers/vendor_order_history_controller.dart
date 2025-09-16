import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class VendorOrderHistoryController extends GetxController {
  var selectedTab = 'Processing'.obs; // 👈 Default 'Processing'
  var allOrders = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  final String apiUrl =
      "http://kotiboxglobaltech.com/sofo_app/api/vendor/received-order-list";

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    print("🚀 VendorOrderHistoryController INIT called");
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      print("⏳ Fetching vendor order history...");
      isLoading.value = true;

      /// 🔑 Get token from storage
      final token = storage.read("token") ?? "";
      print("🔑 Token found: $token");

      if (token.isEmpty) {
        print("⚠️ Token not found! Please login again.");
        allOrders.value = [];
        return;
      }

      print("📡 API CALL -> $apiUrl");
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("📩 API RESPONSE STATUS: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("✅ API RESPONSE DECODED");

        if (data['data'] != null && data['data'] is List) {
          allOrders.value = List<Map<String, dynamic>>.from(data['data']);
          print("📦 Orders loaded: ${allOrders.length}");

          if (allOrders.isNotEmpty) {
            print("📝 Sample Order: ${allOrders.first}");
            print("📝 Status field value: ${allOrders.first['status']}");
          }
        } else {
          print("⚠️ API response format invalid: ${data['data']}");
          allOrders.value = [];
        }
      } else if (response.statusCode == 401) {
        print("🚫 Unauthorized: Token expired or invalid");
        allOrders.value = [];
        storage.erase();
      } else {
        print("⚠️ API Error with status code: ${response.statusCode}");
        allOrders.value = [];
      }
    } catch (e) {
      print("❌ Exception while fetching orders: $e");
      allOrders.value = [];
    } finally {
      isLoading.value = false;
      print("🏁 Fetching orders complete. Total Orders: ${allOrders.length}");
    }
  }

  /// 🔍 Filtered orders based on selectedTab
  List<Map<String, dynamic>> get filteredOrders {
    final filtered = allOrders.where((order) {
      final status = (order['status'] ?? "").toString().toLowerCase();
      final selected = selectedTab.value.toLowerCase();
      return status == selected;
    }).toList();

    print("🔍 Filtered Orders for tab '${selectedTab.value}': ${filtered.length}");
    return filtered;
  }
}
