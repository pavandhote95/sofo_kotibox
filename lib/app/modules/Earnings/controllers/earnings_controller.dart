import 'package:get/get.dart';

class EarningsController extends GetxController {
  final RxInt totalOrders = 15.obs;
  final RxDouble allOrdersEarning = 5000.0.obs;
  final RxDouble cancelledOrdersEarning = 1000.0.obs;

  // Make totalEarnings reactive using a computed Rx getter
  RxDouble get totalEarnings => (allOrdersEarning.value - cancelledOrdersEarning.value).obs;
}
