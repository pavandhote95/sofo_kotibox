import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import '../../../routes/app_pages.dart';

class OrderCancelledView extends StatelessWidget {
  const OrderCancelledView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-right orange curve
            /// Orange decorative shape
           CurvedTopRightBackground(),
        SafeArea(
  child: Column(
    children: [
      const SizedBox(height: 10),
      // Back button
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
        ),
      ),

      const Spacer(),

      // Centered content
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/check.png',
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 30),

          Text(
            'Order Cancelled!',
            style: AppTextStyle.montserrat(
              fs: 20,
              fw: FontWeight.w600,
              c: Colors.black,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Your order has been\nsuccessfully cancelled',
            textAlign: TextAlign.center,
            style: AppTextStyle.montserrat(
              fs: 16,
              c: Colors.grey.shade600,
            ),
          ),
        ],
      ),

      const Spacer(),

      // Bottom button
      SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: CustomButton(
          text: "Next Screen",
          onPressed: () {
           Get.offAllNamed(Routes.DASHBOARD,arguments: 1);
          },
        ),
      ),
    ],
  ),
),

       
        ],
      ),
    );
  }
}
