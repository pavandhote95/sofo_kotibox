import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/modules/Dashboard/views/dashboard_view.dart';
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

  @override
  void onInit() {
    super.onInit();
  }

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
        print('${responseJson["message"]} okkkkkkkkkkkk');
        Utils.showErrorToast(responseJson["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      print('Store List Fetch Error: $e');
      Utils.showErrorToast("Failed to load store list");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getStoreitemList(String storeId) async {
    var storage = GetStorage();
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.getWithAuthApi('${getStoreitemUrl}$storeId');
      print('${getStoreitemUrl}$storeId storeId used in API');
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print('Store List Response: ${response.body}');
        storeItems.value = List<Map<String, dynamic>>.from(responseJson["data"] ?? []);
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorToast(responseJson["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      print('Store List Fetch Error: $e');
      Utils.showErrorToast("Failed to load store list");
    } finally {
      isLoading(false);
    }
  }
}
