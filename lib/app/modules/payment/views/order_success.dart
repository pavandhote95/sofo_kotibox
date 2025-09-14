import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/views/recipt_view.dart';

import '../../../routes/app_pages.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-right orange background circle
          Positioned(
            top: -height * 0.06,
            right: -width * 0.15,
            child: Container(
              height: height * 0.15,
              width: height * 0.23,
              decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(height * 0.2),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                         IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      const SizedBox(width: 20), // balances the row
                    ],
                  ),
                  const SizedBox(height: 80),
                  // Success image (replace with asset if needed)
                  FadeInDown(
                    duration: const Duration(milliseconds: 2000),
                    child: Image.asset(
                      'assets/images/order_success.png',
                      height: height * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 32),
                  Text(
                    'Success!',
                    style: AppTextStyle.montserrat(fs: 26, fw: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'You’ve successfully placed an order.\nYour order will be delivered soon.\nThank you for choosing our app.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.montserrat(fs: 14, c: Colors.black54),
                  ),
                  const Spacer(),
                  // Order Details Button (outlined)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.black87),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {

                        Get.offAllNamed(Routes.DASHBOARD, arguments: 1);
                      },
                      child: Text(
                        "Order Details",
                        style: AppTextStyle.montserrat(
                          fs: 16,
                          fw: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // // Track Order Button (filled orange)
                  // CustomButton(
                  //   text: "Order Details",
                  //   onPressed: () {
                  //        Get.to(() => ReciptView());
                  //     // handle track order
                  //   },
                  // ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
