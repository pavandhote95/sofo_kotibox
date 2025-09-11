import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
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

  /// Wishlist status map
  var wishlistStatus = <int, bool>{}.obs;

  final storage = GetStorage();
  final RestApi restApi = RestApi();

  /// Fetch store details
  Future<void> getStoreList(String storeId) async {
    try {
      isLoading(true);
      final response = await restApi.getWithAuthApi('${getStoreItemListUrl}$storeId');
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200 && responseJson["success"] == true) {
        storeItem.value = storeItemFromJson(response.body);
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorToast(responseJson["message"]);
      }
    } catch (e) {
      print('❌ Store List Fetch Error: $e');
      Utils.showErrorToast("Failed to load store list");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch store items + wishlist status
  Future<void> getStoreitemList(String storeId) async {
    try {
      isLoading(true);
      final response = await restApi.getWithAuthApi('${getStoreitemUrl}$storeId');
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        storeItems.value = List<Map<String, dynamic>>.from(responseJson["data"] ?? []);
        filteredItems.assignAll(storeItems);

        // ✅ Initialize wishlist from API response if available, else local storage
        for (var item in storeItems) {
          int id = item['id'];
          bool status = false;

          if (item.containsKey('is_wishlist')) {
            status = item['is_wishlist'] == 1; // API se wishlist flag
          } else {
            status = storage.read('wishlist_$id') ?? false; // fallback
          }

          wishlistStatus[id] = status;
          storage.write('wishlist_$id', status);
        }
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorToast(responseJson["message"]);
      }
    } catch (e) {
      print('❌ Store Item List Fetch Error: $e');
      Utils.showErrorToast("Failed to load store items");
    } finally {
      isLoading(false);
    }
  }

  /// Search products
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

  /// Toggle wishlist
  Future<void> toggleWishlist(int productId) async {
    try {
      bool currentStatus = wishlistStatus[productId] ?? false;
      wishlistStatus[productId] = !currentStatus; // UI update immediately

      String? token = await restApi.getToken();
      if (token == null) {
        Utils.showErrorToast("User not logged in");
        wishlistStatus[productId] = currentStatus;
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      var url = Uri.parse('http://kotiboxglobaltech.com/sofo_app/api/wishlist/toggle');
      var body = jsonEncode({"storeitem_id": productId});

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Utils.showToast("Wishlist updated");
        // ✅ Store in local storage
        storage.write('wishlist_$productId', wishlistStatus[productId]);
      } else {
        wishlistStatus[productId] = currentStatus; // revert
        Utils.showErrorToast("Failed to update wishlist");
      }
    } catch (e) {
      print('❌ Wishlist toggle error: $e');
      wishlistStatus[productId] = !(wishlistStatus[productId] ?? false);
      Utils.showErrorToast("Something went wrong");
    }
  }
}