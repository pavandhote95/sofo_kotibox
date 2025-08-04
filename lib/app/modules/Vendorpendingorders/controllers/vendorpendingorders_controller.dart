import 'package:get/get.dart';

class VendorPendingOrderController extends GetxController {
  var orders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingOrders();
  }

  void fetchPendingOrders() {
    // Sample data (you can load from API or another source)
    List<Map<String, dynamic>> allOrders = [
      {
        'customerName': 'Arav',
        'orderId': 'ORD123456',
        'itemNames': ['T-shirt', 'Cap', 'Shoes'],
        'date': '17 July 2025',
        'status': 'Delivered',
        'amount': 2349.00,
      },
      {
        'customerName': 'Rahul Verma',
        'orderId': 'ORD789654',
        'itemNames': ['Jacket', 'Watch'],
        'date': '16 July 2025',
        'status': 'Pending',
        'amount': 1299.00,
      },
      {
        'customerName': 'Sita Shah',
        'orderId': 'ORD555888',
        'itemNames': ['Dress', 'Heels'],
        'date': '16 July 2025',
        'status': 'Pending',
        'amount': 2100.00,
      },
    ];

    // Filter only pending orders
    orders.value = allOrders.where((o) => o['status'] == 'Pending').toList();
  }
}
