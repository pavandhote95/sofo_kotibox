import 'package:get/get.dart';

class OrderController extends GetxController {
  var selectedTab = 'Delivered'.obs;

  final allOrders = [
    {
      'status': 'Delivered',
      'orderId': 'Nqers1f5e34',
      'date': '01/01/2022',
      'tracking': 'IW125994257',
      'quantity': 3,
      'amount': 165,
    },
    {
      'status': 'Processing',
      'orderId': 'ABCD123456',
      'date': '05/02/2022',
      'tracking': 'IW987654321',
      'quantity': 1,
      'amount': 99,
    },
    {
      'status': 'Cancelled',
      'orderId': 'XYZ7890LMN',
      'date': '12/03/2022',
      'tracking': 'IW112233445',
      'quantity': 2,
      'amount': 50,
    },
    {
      'status': 'Delivered',
      'orderId': 'DEL112233',
      'date': '15/04/2022',
      'tracking': 'IW446688991',
      'quantity': 2,
      'amount': 120,
    },
    {
      'status': 'Processing',
      'orderId': 'PROC789456',
      'date': '20/04/2022',
      'tracking': 'IW556677889',
      'quantity': 4,
      'amount': 200,
    },
    {
      'status': 'Cancelled',
      'orderId': 'CANC998877',
      'date': '25/04/2022',
      'tracking': 'IW334455667',
      'quantity': 1,
      'amount': 40,
    },
    {
      'status': 'Delivered',
      'orderId': 'DEL556677',
      'date': '30/04/2022',
      'tracking': 'IW778899001',
      'quantity': 5,
      'amount': 300,
    },
    {
      'status': 'Processing',
      'orderId': 'PROC112244',
      'date': '05/05/2022',
      'tracking': 'IW990011223',
      'quantity': 2,
      'amount': 89,
    },
    {
      'status': 'Delivered',
      'orderId': 'DEL334466',
      'date': '10/05/2022',
      'tracking': 'IW334488990',
      'quantity': 1,
      'amount': 70,
    },
    {
      'status': 'Cancelled',
      'orderId': 'CANC554433',
      'date': '15/05/2022',
      'tracking': 'IW220033445',
      'quantity': 3,
      'amount': 115,
    },
    {
      'status': 'Delivered',
      'orderId': 'DEL778899',
      'date': '20/05/2022',
      'tracking': 'IW119988776',
      'quantity': 4,
      'amount': 250,
    },
    {
      'status': 'Processing',
      'orderId': 'PROC667788',
      'date': '25/05/2022',
      'tracking': 'IW880099112',
      'quantity': 2,
      'amount': 140,
    },
    {
      'status': 'Cancelled',
      'orderId': 'CANC889900',
      'date': '30/05/2022',
      'tracking': 'IW445566778',
      'quantity': 1,
      'amount': 65,
    },
    {
      'status': 'Delivered',
      'orderId': 'DEL990011',
      'date': '01/06/2022',
      'tracking': 'IW221133445',
      'quantity': 2,
      'amount': 110,
    },
    {
      'status': 'Processing',
      'orderId': 'PROC332211',
      'date': '05/06/2022',
      'tracking': 'IW559988776',
      'quantity': 3,
      'amount': 170,
    },
  ].obs;


  List<Map<String, dynamic>> get filteredOrders =>
      allOrders.where((order) => order['status'] == selectedTab.value).toList();
}
