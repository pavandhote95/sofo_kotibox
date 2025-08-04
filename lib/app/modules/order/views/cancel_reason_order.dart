import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/controllers/cancel_order_controller';
import 'package:sofo/app/modules/order/views/bottom_sheet_cancel_order.dart';


import 'order_cancel._view.dart';

class CancelReasonView extends StatelessWidget {
  const CancelReasonView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final controller = Get.put(CancelOrderController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-right curve
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
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Cancel Order",
                            style: AppTextStyle.montserrat(
                              fs: 20,
                              fw: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Options
                Obx(() => Column(
                      children: List.generate(controller.reasons.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: InkWell(
                            onTap: () => controller.selectReason(index),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.reasons[index],
                                    style: AppTextStyle.montserrat(
                                      fs: 15,
                                      fw: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    controller.selectedReasonIndex.value == index
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: AppColor.orange,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    )),

                const SizedBox(height: 30),

   // Cancel Order Button
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: CustomButton(
    text: "Cancel Order",
    onPressed: () {
        //Get.to(() =>  OrderOverviewView());
      // Show confirmation dialog first
      showCancelOrderDialogIOS(
        onYes: () {
        Get.to(OrderCancelledView());
        
        },
      );
    },
  ),
),

                const Spacer(),

                // Contact Support
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar("Support", "Contacting support...");
                    },
                    child: Text(
                      "Contact Support",
                      style: AppTextStyle.montserrat(
                        fs: 14,
                        fw: FontWeight.w500,
                        c: AppColor.orange,
                      ),
                    ),
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
