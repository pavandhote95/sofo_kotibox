import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendorallorders_controller.dart';

class VendorOrdersView extends StatelessWidget {
  VendorOrdersView({super.key});
  final VendorAllOrderController controller = Get.put(VendorAllOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(), // Background design
          Column(
            children: [
                CustomAppBar(
                title: "Vendor Orders",
                onActionTap: null,
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.orders.length,
                    itemBuilder: (context, index) {
                      final order = controller.orders[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.user,
                                      size: 18,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Customer: ${order['customerName'] ?? 'N/A'}",
                                      style: AppTextStyle.montserrat(
                                          fs: 14, fw: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.hashtag,
                                      size: 16,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Order ID: ${order['orderId'] ?? 'N/A'}",
                                      style: AppTextStyle.montserrat(
                                          fs: 13, fw: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Items: ${order['itemNames']?.join(', ') ?? 'N/A'}",
                                  style: AppTextStyle.montserrat(
                                      fs: 13, fw: FontWeight.w400),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date: ${order['date'] ?? ''}",
                                      style: AppTextStyle.montserrat(
                                          fs: 12, fw: FontWeight.w400),
                                    ),
                                    Text(
                                      "Status: ${order['status'] ?? ''}",
                                      style: AppTextStyle.montserrat(
                                          fs: 12,
                                          fw: FontWeight.w500,
                                          c:Colors.orange),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Total: ₹ ${order['amount'] ?? '0'}",
                                  style: AppTextStyle.montserrat(
                                      fs: 14,
                                      fw: FontWeight.bold,
                                      c: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
