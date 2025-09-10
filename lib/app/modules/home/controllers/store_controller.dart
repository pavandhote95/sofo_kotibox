import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/auth_helper.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../data/store_about.dart';
import '../../../data/store_item.dart';
import '../../../services/api_service.dart';

class StoreController extends GetxController {
  var isLoading = false.obs;
  var storeItem = StoreItem().obs;
  var storeAbout = StoreAboutData().obs;
  var storeItems = <Map<String, dynamic>>[].obs;
  var filteredItems = <Map<String, dynamic>>[].obs;
  var searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  /// 🔹 Centralized error toast (only for API)
  void showError(String? message) {
    // Prevent showing duplicate toast if already loading
    if (!isLoading.value) return;
    Utils.showErrorToast(message ?? "Something went wrong!");
  }

  /// 🔹 Store Details API
  Future<void> getStoreList(String storeId) async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.getWithAuthApi('${getStoreItemListUrl}$storeId');
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200 && responseJson["success"] == true) {
        storeItem.value = storeItemFromJson(response.body);
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        showError(responseJson["message"]);
      }
    } catch (e) {
      print('Store List Fetch Error: $e');
      showError("Failed to load store list");
    } finally {
      isLoading(false);
    }
  }

  /// 🔹 Store Items API
  Future<void> getStoreitemList(String storeId) async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.getWithAuthApi('${getStoreitemUrl}$storeId');
      print('${getStoreitemUrl}$storeId storeId used in API');
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        storeItems.value = List<Map<String, dynamic>>.from(responseJson["data"] ?? []);
        filteredItems.assignAll(storeItems); // default load
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();





        
      } else {
        showError(responseJson["message"]);
      }
    } catch (e) {
      print('Store Item List Fetch Error: $e');
      showError("Failed to load store items");
    } finally {
      isLoading(false);
    }
  }

  /// 🔍 Search (⚡ No Toasts here)
  void searchItems(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredItems.assignAll(storeItems);
    } else {
      filteredItems.assignAll(
        storeItems.where((item) {
          final name = (item['name'] ?? '').toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList(),
      );
    }
  }
}
