import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sofo/app/custom_widgets/snacbar.dart';
import 'package:sofo/app/modules/home/controllers/store_controller.dart';
class WhishlistController extends GetxController {
  var wishlist = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  final storage = GetStorage();
  int? appUserId;
  String? token;

  StoreController get storeController {
    return Get.isRegistered<StoreController>()
        ? Get.find<StoreController>()
        : Get.put(StoreController());
  }

  @override
  void onInit() {
    super.onInit();
    appUserId = storage.read('userId');
    token = storage.read('token');
    if (appUserId != null) {
      fetchWishlist();
    }
  }

  /// ✅ Fetch wishlist
  Future<void> fetchWishlist() async {
    if (appUserId == null) return;

    try {
      isLoading.value = true;
      wishlist.clear();

      final url = Uri.parse(
          "http://kotiboxglobaltech.com/sofo_app/api/wishlist?app_user_id=$appUserId");

      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true && data["data"] != null) {
          final list = List<Map<String, dynamic>>.from(data["data"]);
          wishlist.addAll(list);

          // Update storeController status
          storeController.wishlistStatus.clear();
          for (var item in storeController.storeItems) {
            int id = item['id'];
            bool isFav = list.any((wish) => wish['id'] == id);
            storeController.wishlistStatus[id] = isFav;
            storeController.storage.write('wishlist_$id', isFav);
          }
          storeController.wishlistStatus.refresh();
        }
      }
    } catch (e) {
      print("❌ Wishlist fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Add to wishlist
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    try {
      final url =
          Uri.parse("http://kotiboxglobaltech.com/sofo_app/api/wishlist/add");

      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer $token"},
        body: {
          "app_user_id": appUserId.toString(),
          "product_id": product['id'].toString(),
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        wishlist.add(product);

        storeController.wishlistStatus[product['id']] = true;
        storeController.storage.write('wishlist_${product['id']}', true);
        storeController.wishlistStatus.refresh();

        // ✅ Toast
        Utils.showToast(data["message"] ?? "Added to wishlist");
      } else {
        Utils.showErrorToast(data["message"] ?? "Failed to add");
      }
    } catch (e) {
      print("❌ Add to wishlist error: $e");
      Utils.showErrorToast("Something went wrong");
    }
  }

  /// ✅ Remove from wishlist
 /// ✅ Remove from wishlist
/// ✅ Remove from wishlist
Future<void> removeFromWishlist(int productId) async {
  try {
    final url = Uri.parse(
        "http://kotiboxglobaltech.com/sofo_app/api/wishlist/delete/$productId");

    final response = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["status"] == true) {
      // Remove from local wishlist
      wishlist.removeWhere((item) => item['id'] == productId);

      // ✅ Update storeController state directly
      storeController.wishlistStatus[productId] = false;
      storeController.storage.write('wishlist_$productId', false);
      storeController.wishlistStatus.refresh();
      storeController.toggleWishlist(productId); // UI refresh

      // ✅ Toast
      Utils.showToast(data["message"] ?? "Removed from wishlist");
    } else {
      Utils.showErrorToast(data["message"] ?? "Failed to remove");
    }
  } catch (e) {
    print("❌ Remove wishlist error: $e");
    Utils.showErrorToast("Something went wrong");
  }
}


}

 