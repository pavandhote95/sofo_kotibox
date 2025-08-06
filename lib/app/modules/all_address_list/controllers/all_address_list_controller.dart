import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofo/app/custom_widgets/api_url.dart';
import 'package:sofo/app/services/api_service.dart';


class AllAddressListController extends GetxController {
  final RestApi api = RestApi();

  RxList<Map<String, dynamic>> addressList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    isLoading.value = true;
    try {
      final http.Response response = await api.getWithAuthApi(addressListApi);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['status'] == true) {
          final List<dynamic> data = jsonData['data'];
          addressList.value = List<Map<String, dynamic>>.from(data);
        } else {
          Get.snackbar("Error", jsonData['message']);
        }
      } else {
        Get.snackbar("Server Error", "Status Code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
