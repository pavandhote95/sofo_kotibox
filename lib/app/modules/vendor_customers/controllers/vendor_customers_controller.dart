import 'package:get/get.dart';

class CustomersController extends GetxController {
  var customersList = [].obs;

  // Add these two lines 👇
  var walletBalance = 120.0.obs;
  var transactions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchCustomers();
    fetchWalletData(); // add this call
    super.onInit();
  }

  void fetchCustomers() {
    customersList.value = [
      {'name': 'John Doe', 'email': 'john@example.com'},
      {'name': 'Jane Smith', 'email': 'jane@example.com'},
    ];
  }

  void fetchWalletData() {
    walletBalance.value = 120.0;
    transactions.value = [
      {'description': 'Ride Payment', 'amount': -20.0},
      {'description': 'Top-up', 'amount': 100.0},
      {'description': 'Refund', 'amount': 40.0},
    ];
  }
}
