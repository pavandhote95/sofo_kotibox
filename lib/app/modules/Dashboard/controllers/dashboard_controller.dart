import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/modules/account/views/account_view.dart';
import 'package:sofo/app/modules/home/views/ProductDetails/product_details_view.dart';
import 'package:sofo/app/modules/order/views/order_view.dart';

import '../../cart/views/cart_view.dart';
import '../../home/views/home_view.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeView(),
    OrderView(),
    CartView(),
    AccountView(),
 
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is int) {
      selectedIndex = Get.arguments;
    }
    super.onInit();
  }
}
