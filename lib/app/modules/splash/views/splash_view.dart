import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/loder.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});
  @override
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Centered logo
          Center(child: Image.asset('assets/images/Dropd.png', width: 120)),

          // Bottom loading indicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(child: CustomLoadingIndicator()),
          ),
        ],
      ),
    );
  }
}
