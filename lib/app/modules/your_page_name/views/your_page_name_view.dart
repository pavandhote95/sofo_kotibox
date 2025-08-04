import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/your_page_name_controller.dart';

class YourPageNameView extends GetView<YourPageNameController> {
  const YourPageNameView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YourPageNameView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'YourPageNameView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
