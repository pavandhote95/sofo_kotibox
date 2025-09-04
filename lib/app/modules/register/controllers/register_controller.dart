import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/modules/login/controllers/login_controller.dart';
import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final mobileFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  var isLoading = false.obs;

  void postRegisterApi() async {
    final pass = passwordController.text.trim();
    String request = json.encode({
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "mobile": mobileController.text.trim(),
      "password": pass,
    });

    try {
      isLoading(true);
      RestApi restApi = RestApi();
      var response = await restApi.postApi(postRegisterUrl, request);
      var responseJson = json.decode(response.body);

      if (response.statusCode == 201 && responseJson['status'] == true) {
        Utils.showToast(responseJson["message"]);

        /// delete previous login controller so fields reinitialize
        Get.delete<LoginController>(force: true);

        /// go back to login
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
          Utils.showErrorSnackbar("Error", responseJson["message"] ?? "Something went wrong!");
        }
      }
    } catch (e) {
      print("This is error: $e");
      Utils.showErrorSnackbar("Exception", "Something went wrong. Please try again.");
    } finally {
      isLoading(false);
    }
  }
}
