// lib/validations/vendor_validations.dart

import 'package:sofo/app/custom_widgets/snacbar.dart';

class VendorValidations {
  static bool validateVendorFields({
    required String shopName,
    required String gst,
    required String pan,
    required String tan,
    required String address,
    required String categories,
    required String otherCategory,
  }) {
    final RegExp gstRegex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$');
    final RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    final RegExp tanRegex = RegExp(r'^[A-Z]{4}[0-9]{5}[A-Z]{1}$');

    if (shopName.isEmpty) {
      Utils.showErrorToast("Shop Name is required");
      return false;
    } else if (gst.isEmpty ) {
      Utils.showErrorToast("Enter a valid GST Number");
      return false;
    } else if (pan.isEmpty) {
      Utils.showErrorToast("Enter a valid PAN Number");
      return false;
    // } else if (tan.isNotEmpty ) {
    //   Utils.showErrorToast("Enter a valid TAN Number");
    //   return false;
    // } else if (address.isEmpty) {
    //   Utils.showErrorToast("Address is required");
    //   return false;
    } else if (categories.isEmpty) {
      Utils.showErrorToast("At least one Shop Category is required");
      return false;
    } else if (categories.contains('Other') && otherCategory.isEmpty) {
      Utils.showErrorToast("Other Category Details are required");
      return false;
    }

    return true; // All validations passed
  }
}
