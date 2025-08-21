import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sofo/app/modules/account/controllers/account_controller.dart';

import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/auth_helper.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../data/profile_model.dart';
import '../../../services/api_service.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileModel = ProfileModel().obs;

  // Profile Image
  var selectedImage = Rx<File?>(null);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
    getEditHostData();
  }

  /// Fetch Profile
  Future<void> getEditHostData() async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.getWithAuthApi(getProfile);
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200 && responseJson["status"]) {
        profileModel.value = profileModelFromJson(response.body);
        nameController.text = profileModel.value.name ?? '';
        emailController.text = profileModel.value.email ?? '';
        phoneController.text = profileModel.value.mobile ?? '';
        AccountController().fetchUserProfile();
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorSnackbar(
          "Error",
          responseJson["message"] ?? "Something went wrong!",
        );
      }
    } catch (e) {
      Utils.showErrorSnackbar("Exception", "Failed to load profile");
    } finally {
      isLoading(false);
    }
  }

  /// Pick Image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  /// Update Profile
  Future<void> updateProfile() async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();

      final response = await restApi.postMultipartApiWithAuth(
        "https://kotiboxglobaltech.com/sofo_app/api/auth/update-profile",
        {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "mobile": phoneController.text.trim(),
        },
        fileKey: "profile_image",
        file: selectedImage.value,
      );

      final responseJson = json.decode(response.body);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseJson["status"] == true) {
          
 
        Utils.showToast(responseJson["message"] ?? "Profile Updated");
        Get.back();
        
        await getEditHostData();
      } else {
        Utils.showErrorSnackbar("Error", responseJson["message"] ?? "Update failed!");
      }
    } catch (e) {
      Utils.showErrorSnackbar("Exception", "Something went wrong. Try again.");
    } finally {
      isLoading(false);
    }
  }
}
