 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sofo/app/custom_widgets/curved_top_container.dart';


import 'package:sofo/app/modules/order/views/track_order.dart';

import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_fonts.dart';

import 'cancel_reason_order.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// Decorative curved background
          const CurvedTopRightBackground(),

          /// Main content
          Column(
            children: [
              /// Header
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isWideScreen ? 24 : 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      Text(
                        'Order Details',
                        style: AppTextStyle.montserrat(
                          fs: isWideScreen ? 22 : 18,
                          fw: FontWeight.w600,
                          c: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 40), // for centering
                    ],
                  ),
                ),
              ),

              /// Scrollable Content
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: isWideScreen ? 24 : 16),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 600),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Product Info with Image
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      "https://t3.ftcdn.net/jpg/03/99/94/76/360_F_399947612_qLbYFr1SVD2BRt4Haten9drbPJ4wfw4M.jpg",
                                      width: isWideScreen ? 60 : 50,
                                      height: isWideScreen ? 60 : 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    "Furniture Hub (Furniture Dealers Association Member)",
                                    style: AppTextStyle.montserrat(
                                      fs: isWideScreen ? 15 : 14,
                                      fw: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Kensington, SW10 2PL",
                                        style: AppTextStyle.montserrat(
                                          fs: isWideScreen ? 13 : 12,
                                          c: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),

                                /// Info Rows
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildLabelValue("Date", "Dec 22, 2024", isWideScreen),
                                    buildLabelValue("Product", "3 Items", isWideScreen),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildLabelValue("Courier", "Mike Davis", isWideScreen),
                                    buildLabelValue("Status", "Completed", isWideScreen,
                                        color: AppColor.orange),
                                  ],
                                ),
                                const Divider(height: 30),

                                /// Price Breakdown
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Price", style: AppTextStyle.montserrat(c: Colors.grey)),
                                    Text("\$34.00",
                                        style: AppTextStyle.montserrat(fw: FontWeight.w600)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Fee", style: AppTextStyle.montserrat(c: Colors.grey)),
                                    Text("\$1.55",
                                        style: AppTextStyle.montserrat(fw: FontWeight.w600)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total", style: AppTextStyle.montserrat(c: Colors.grey)),
                                    Text("\$35.55",
                                        style: AppTextStyle.montserrat(fw: FontWeight.w700)),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                /// Barcode section
                                Center(
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://www.shutterstock.com/image-vector/barcode-icon-vector-simple-fake-600nw-2497908549.jpg',
                                        height: isWideScreen ? 100 : 80,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "LDI123456789",
                                        style: AppTextStyle.montserrat(fw: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),


                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomButton(
                  text: "Track Order",
                  onPressed: () {
                    Get.to(() => MapDeliveryStatusView());
                  },
                ),
              ),
              SizedBox(height: 10,),

              /// Cancel Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomButton(
                  text: "Cancel Order",
                  onPressed: () {
                    Get.to(() => CancelReasonView());
                  },
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLabelValue(String label, String value, bool isWideScreen, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyle.montserrat(
              fs: isWideScreen ? 14 : 13,
              c: Colors.grey,
            )),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.montserrat(
            fs: isWideScreen ? 15 : 14,
            fw: FontWeight.w600,
            c: color ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
