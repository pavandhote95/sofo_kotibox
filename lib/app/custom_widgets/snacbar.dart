// ignore_for_file: non_constant_identifier_names


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';



class Utils {

  /// Show a green success snackbar with title and message.
  static void showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show a red error snackbar with title and message.
  static void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show a green toast message (typically used for success).
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  /// Show a red toast message (typically used for error).
  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  /// Validates if the given string is a proper email.
  static bool isValidEmail(String email) {
    final emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }




  static void showiOSConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(
          title,
          style: AppTextStyle.montserrat(
            fs: 17,
            fw: FontWeight.w600,
            c: CupertinoColors.black,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            message,
            style: AppTextStyle.montserrat(
              fs: 15,
              c: CupertinoColors.black, fw: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            isDestructiveAction: false,
            child: Text(
              'Cancel',
              style: AppTextStyle.montserrat(

             fs: 15, c: Colors.black, fw: FontWeight.w600,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              onConfirm();
            },
            isDefaultAction: true,
            child: Text(
              'Confirm',
              style: AppTextStyle.montserrat(

                fs: 15, c: Colors.red, fw: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }




}
