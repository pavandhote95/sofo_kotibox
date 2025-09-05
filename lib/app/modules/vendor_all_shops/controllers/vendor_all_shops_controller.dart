import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofo/app/modules/home/controllers/store_controller.dart';

class VendorAllShopsController extends GetxController {
  var isLoading = false.obs;
  var storeList = [].obs;

  final storeController = Get.put(StoreController());


  @override
  void onInit() {
    super.onInit();
    fetchShops();
  }

  Future<void> fetchShops() async {
    try {
      isLoading(true);

      // Use storeController property here
      var url = Uri.parse(
        "https://kotiboxglobaltech.com/sofo_app/api/user/store/3",
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data["data"] != null) {
          storeList.value = data["data"];
        } else {
          storeList.clear();
        }
      } else {
        storeList.clear();
      }
    } catch (e) {
      storeList.clear();
    } finally {
      isLoading(false);
    }
  }
}
