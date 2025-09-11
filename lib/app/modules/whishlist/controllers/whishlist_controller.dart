import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WhishlistController extends GetxController {
  // ✅ Observable list
  var wishlist = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  final int appUserId = 3; // dummy id (dynamic bhi kar sakte ho)

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  /// ✅ Fetch wishlist from API
  Future<void> fetchWishlist() async {
    try {
      isLoading.value = true;
      wishlist.clear();

      final url = Uri.parse(
          "http://kotiboxglobaltech.com/sofo_app/api/wishlist?app_user_id=$appUserId");

      print("🔹 Fetching wishlist: $url");

      final response = await http.get(url);

      print("🔹 Response Code: ${response.statusCode}");
      print("🔹 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // ✅ Correct keys: success + data
        if (data["success"] == true && data["data"] != null) {
          wishlist.addAll(
            List<Map<String, dynamic>>.from(data["data"]),
          );
        }
      } else {
        print("❌ Failed to fetch wishlist: ${response.reasonPhrase}");
      }
    } catch (e, stack) {
      print("❌ Wishlist fetch error: $e");
      print(stack);
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Remove item locally
  void removeFromWishlist(int index) {
    wishlist.removeAt(index);
  }
}
