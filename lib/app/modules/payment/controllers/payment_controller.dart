import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> paymentOptions = [
    {'icon': Icons.account_balance_wallet, 'title': 'Wallet'},
    {'image': 'assets/icons/apple.png', 'title': 'Apple Pay'},
    {'image': 'assets/icons/stripe.png', 'title': 'Stripe'},
    {'image': 'assets/icons/asian_bank.png', 'title': 'Asian Bank'},
  ];

  void selectPayment(int index) {
    selectedIndex = index;
    update(); // notify GetBuilder to rebuild
  }
}
