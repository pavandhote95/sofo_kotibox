import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/modules/order/views/track_order.dart';

import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_fonts.dart';

class OrderOverviewView extends StatelessWidget {
  OrderOverviewView({super.key});

  final List<String> steps = const [
    "Order Confirmed",
    "Preparing Your Order",
    "Delivery In Progress",
    "Delivery man is picking up your order",
    "Delivery man is nearly your place"
  ];

  final int currentStep = 3;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        "Order Overview",
                        style: AppTextStyle.montserrat(
                          fs: 20,
                          fw: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text("Order id: 9856314753",
                          style: AppTextStyle.montserrat(fs: 14)),
                      Text("Order price: \$999",
                          style: AppTextStyle.montserrat(fs: 14)),
                      const SizedBox(height: 4),
                      Text("5 hours ago",
                          style:
                              AppTextStyle.montserrat(fs: 12, c: Colors.grey)),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: steps.length,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemBuilder: (context, index) {
                      final isCompleted = index < currentStep;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: isCompleted
                                    ? AppColor.orange
                                    : Colors.grey,
                                child: isCompleted
                                    ? const Icon(Icons.check,
                                        size: 12, color: Colors.white)
                                    : const Icon(Icons.circle,
                                        size: 12, color: Colors.white),
                              ),
                              if (index != steps.length - 1)
                                Container(
                                  width: 2,
                                  height: 40,
                                  color: isCompleted
                                      ? AppColor.orange
                                      : Colors.grey.shade300,
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                steps[index],
                                style: AppTextStyle.montserrat(
                                  fs: 14,
                                  c: isCompleted ? Colors.black : Colors.grey,
                                  fw: isCompleted
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: CustomButton(
                    key: UniqueKey(),
                    text: "View map",
                    onPressed: () {
                    Get.back();
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Need help ",
                          style: AppTextStyle.montserrat(
                            fs: 13,
                            c: AppColor.orange,
                            fw: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "with ",
                          style: AppTextStyle.montserrat(
                            fs: 13,
                            c: Colors.grey,
                            fw: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "your ",
                          style: AppTextStyle.montserrat(
                            fs: 13,
                            c: AppColor.orange,
                            fw: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "Order",
                          style: AppTextStyle.montserrat(
                            fs: 13,
                            c: Colors.grey,
                            fw: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
