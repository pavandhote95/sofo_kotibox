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

  /// ✅ Wishlist status map
  var wishlistStatus = <int, bool>{}.obs;

  final storage = GetStorage();
  final RestApi restApi = RestApi();

  /// Fetch store details
  Future<void> getStoreList(String storeId) async {
    try {
      isLoading(true);
      final response =
          await restApi.getWithAuthApi('${getStoreItemListUrl}$storeId');
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
      final response =
          await restApi.getWithAuthApi('${getStoreitemUrl}$storeId');
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        storeItems.value =
            List<Map<String, dynamic>>.from(responseJson["data"] ?? []);
        filteredItems.assignAll(storeItems);

        // ✅ Initialize wishlist correctly
        for (var item in storeItems) {
          int id = item['id'];
          bool status = false;

          if (item.containsKey('is_wishlist')) {
            status = item['is_wishlist'] == 1; // API flag
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
/// Toggle wishlist
/// Toggle wishlist
Future<void> toggleWishlist(int productId) async {
  try {
    bool currentStatus = wishlistStatus[productId] ?? false;
    wishlistStatus[productId] = !currentStatus; // UI instant update

    print("🔄 Toggling wishlist for Product ID: $productId");
    print("🔹 Current local status: $currentStatus");

    String? token = await restApi.getToken();
    if (token == null) {
      print("❌ User not logged in");
      Utils.showErrorToast("User not logged in");
      wishlistStatus[productId] = currentStatus; // revert
      return;
    }

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var url = Uri.parse('http://kotiboxglobaltech.com/sofo_app/api/wishlist/toggle');
    var body = jsonEncode({"storeitem_id": productId});

    print("🟠 API Request URL: $url");
    print("🟠 Request Body: $body");

    var response = await http.post(url, headers: headers, body: body);

    print("🟢 Raw Response Code: ${response.statusCode}");
    print("🟢 Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      print("🟢 Decoded Response: $resp");

      if (resp["success"] == true) {
        bool apiLiked = resp["liked"] ?? false;

        // ✅ update state according to API response
        wishlistStatus[productId] = apiLiked;

        // ✅ Save locally
        storage.write('wishlist_$productId', apiLiked);

        print("✅ API Liked: $apiLiked (Product $productId)");
        Utils.showToast(resp["message"]);
      } else {
        wishlistStatus[productId] = currentStatus; // revert
        print("⚠️ API Failed: ${resp["message"]}");
        Utils.showErrorToast(resp["message"]);
      }
    } else {
      wishlistStatus[productId] = currentStatus; // revert
      print("❌ Wishlist update failed. Status: ${response.statusCode}");
      Utils.showErrorToast("Failed to update wishlist");
    }
  } catch (e) {
    print('❌ Wishlist toggle error: $e');
    // ❌ yaha ulta karna galat tha
    // ✅ sahi: original status par revert karo
    wishlistStatus[productId] = wishlistStatus[productId] ?? false;
    Utils.showErrorToast("Something went wrong");
  }
}
}