import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var storage = GetStorage();

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // FocusNodes
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // Remember Me
  final rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(update);
    passwordController.addListener(update);
    emailFocusNode.addListener(update);
    passwordFocusNode.addListener(update);
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   emailFocusNode.dispose();
  //   passwordFocusNode.dispose();
  //   super.onClose();
  // }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void postLoginApi() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    // Local validation
    if (email.isEmpty) {
      Utils.showErrorToast("Email is required");
      return;
    } else if (password.isEmpty) {
      Utils.showErrorToast("Password is required");
      return;
    }
    String request = json.encode({"email": email, "password": password});
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      var response = await restApi.postApi(postLoginUrl, request);
      var responseJson = json.decode(response.body);
      if (response.statusCode == 201 && responseJson['status'] == true) {
        Utils.showToast(responseJson["message"] ?? "Login successful");
        storage.write('isLogin', true);
        storage.write('token', responseJson['data']['access_token']);
        Get.offAllNamed(Routes.DASHBOARD);
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
          Utils.showErrorSnackbar(
            "Error",
            responseJson["message"] ?? "Login failed! Try again.",
          );
        }
      }
    } catch (e) {
      print("Login API Error: $e");
      Utils.showErrorSnackbar(
        "Exception",
        "Something went wrong. Please try again.",
      );
    } finally {
      isLoading(false);
    }
  }
}
