import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';

class AccountController extends GetxController {
  var isLoading = false.obs;
  var storage = GetStorage();

  // User Profile Observables
  var name = ''.obs;
  var email = ''.obs;
  var mobile = ''.obs;
  var userid = ''.obs;
  var profileImageUrl = ''.obs;
  var becomeVendor = ''.obs;
  var vendorStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.getWithAuthApi(
        "https://kotiboxglobaltech.com/sofo_app/api/auth/user-profile",
      );

      final data = json.decode(response.body);

      if (data["status"] == true) {
        final profile = data["data"];
        userid.value = profile["id"].toString();
        name.value = profile["name"] ?? '';
        email.value = profile["email"] ?? '';
        mobile.value = profile["mobile"] ?? '';
        profileImageUrl.value = profile["profile_image_url"] ?? '';
        becomeVendor.value = profile["become_vendor"] ?? '';
        vendorStatus.value = profile["vendor_status"] ?? '';

        storage.write('userid', userid.value);
      } else {
        Utils.showErrorSnackbar(
            "Failed", data["message"] ?? "Failed to fetch profile");
      }
    } catch (e) {
      debugPrint("❌ Error fetching profile: $e");
    } finally {
      isLoading(false);
    }
  }

  void postLogOut() async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.postApiWithAuth(postLogout, "");
      final responseJson = json.decode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseJson["status"] == true) {
        Utils.showToast(responseJson["message"] ?? "Logout successful");

        // ✅ clear session
        storage.erase();

        Get.offAllNamed(Routes.LOGIN);
      } else {
        isLoading(false);
        if (responseJson["errors"] != null) {
          String errorMessages = "";
          responseJson["errors"].forEach((key, value) {
            if (value is List) {
              errorMessages += "${value.join("\n")}\n";
            }
          });
          Utils.showErrorSnackbar("Validation Error", errorMessages.trim());
        } else {
          Get.offAllNamed(Routes.LOGIN);
          Utils.showErrorSnackbar(
              "Error", responseJson["message"] ?? "Logout failed! Try again.");
        }
      }
    } catch (e) {
      Utils.showErrorSnackbar(
          "Exception", "Something went wrong. Please try again.");
    } finally {
      isLoading(false);
    }
  }
}
