import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_pages.dart';
import 'snacbar.dart'; // Optional: for error messages

class AuthHelper {
  static final _storage = GetStorage();

  static void handleUnauthorized() {
    // Clear any stored login data
    _storage.write("token", "");
    _storage.write("login",false );
    // Show error message
    Utils.showErrorToast("Session expired. Please login again.");

    // Navigate to login
    Get.offAllNamed(Routes.LOGIN);
  }
}
