import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../Earnings/controllers/earnings_controller.dart';

class VendorEarningView extends StatelessWidget {
  const VendorEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EarningsController());
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),
          Column(
            children: [
              CustomAppBar(title: "My Earnings"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Obx(() => Column(
                    children: [
                      _earningTile("Total Orders", controller.totalOrders.value.toString(), width),
                      _earningTile("All Orders Earning", "₹${controller.allOrdersEarning.value}", width),
                      _earningTile("Cancelled Orders Earning", "₹${controller.cancelledOrdersEarning.value}", width),
                      const Divider(height: 32),
                      _earningTile("Total Earnings", "₹${controller.totalEarnings.value}", width, highlight: true),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _earningTile(String title, String value, double width, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: highlight ? Colors.green.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.montserrat(
              fs: width * 0.042,
              fw: FontWeight.w500,
              c: highlight ? Colors.green.shade900 : Colors.black,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.montserrat(
              fs: width * 0.045,
              fw: FontWeight.w600,
              c: highlight ? Colors.green.shade900 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
