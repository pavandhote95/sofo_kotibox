import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/auth_helper.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../data/profile_model.dart';
import '../../../services/api_service.dart';

class ProfileController extends GetxController {
  var isEditing = false.obs;
  var isLoading = false.obs;
var profileModel = ProfileModel().obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  void onInit(){
    super.onInit();
    getEditHostData();
  }


  Future<void> getEditHostData() async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.getWithAuthApi(getProfile);
      final responseJson = json.decode(response.body);
      if (response.statusCode == 201 && responseJson["status"]) {
        print(response.body);
        profileModel.value = profileModelFromJson(response.body);
        nameController.text = profileModel.value.name ?? '';
        emailController.text = profileModel.value.email ?? '';
        phoneController.text = profileModel.value.mobile ?? '';
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorSnackbar("Error", responseJson["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      print('Profile Fetch Error: $e');
      Utils.showErrorSnackbar("Exception", "Failed to load profile");
    } finally {
      isLoading(false);
    }
  }


}
