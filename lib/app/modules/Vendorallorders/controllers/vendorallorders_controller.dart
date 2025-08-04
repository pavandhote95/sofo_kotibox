import 'package:get/get.dart';

class VendorAllOrderController extends GetxController {
  var orders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    // Sample data
    orders.value = [
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
      },   {
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
    ];
  }
}
