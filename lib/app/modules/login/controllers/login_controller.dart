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
  final storage = GetStorage();

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

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  Future<void> postLoginApi() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

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
        // ✅ Extract values
        final token = responseJson['data']['token'];
        final userData = responseJson['data']['user'] ?? {};
        final int userId = userData['id'] ?? 0;
        final String name = userData['name'] ?? "";
        final String email = userData['email'] ?? "";

        // ✅ Save in storage
        storage.write('isLogin', true);
        storage.write('token', token);
        storage.write('userId', userId);
        storage.write('userName', name);
        storage.write('userEmail', email);

        debugPrint("📦 Token: $token");
        debugPrint("🆔 UserId: $userId");
        debugPrint("👤 Name: $name");
        debugPrint("📧 Email: $email");

        Utils.showToast(responseJson["message"] ?? "Login successful");
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        String errorMessage = "Login failed! Try again.";

        if (response.statusCode == 401 ||
            (responseJson["message"]?.toString().toLowerCase().contains("invalid") ?? false)) {
          errorMessage = "Email or password is incorrect.";
        } else if (responseJson["message"]?.toString().toLowerCase().contains("token expire") ?? false) {
          storage.erase();
          Get.offAllNamed(Routes.LOGIN);
          return;
        } else if (responseJson["errors"] != null) {
          String errorMessages = "";
          responseJson["errors"].forEach((key, value) {
            if (value is List) {
              errorMessages += "${value.join("\n")}\n";
            }
          });
          errorMessage = errorMessages.trim();
        } else if (responseJson["message"] != null) {
          errorMessage = responseJson["message"];
        }

        Utils.showErrorToast(errorMessage);
      }
    } catch (e) {
      debugPrint("Login API Error: $e");
      Utils.showErrorToast("Something went wrong. Please try again.");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
