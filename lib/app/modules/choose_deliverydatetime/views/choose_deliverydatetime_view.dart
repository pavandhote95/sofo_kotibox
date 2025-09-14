import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/choose_deliverydatetime_controller.dart';

class ChooseDeliverydatetimeView
    extends GetView<ChooseDeliverydatetimeController> {
  const ChooseDeliverydatetimeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChooseDeliverydatetimeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChooseDeliverydatetimeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
