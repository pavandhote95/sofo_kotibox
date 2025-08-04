import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendorwallet_controller.dart';

class WalletsPage extends StatelessWidget {
  WalletsPage({super.key});

  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColor.white,

        body: Stack(
    children: [
      const CurvedTopRightBackground(),

      Column(
        children: [
          CustomAppBar(title: "My Wallets"),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                _walletTile("Main Wallet", "₹${controller.mainWallet.value}", width),
                _walletTile("Bonus Wallet", "₹${controller.bonusWallet.value}", width),
                _walletTile("Referral Wallet", "₹${controller.referralWallet.value}", width),
                const Divider(height: 32),
                _walletTile("Total Wallet Balance", "₹${controller.totalWallet.value}", width, highlight: true),
              ],
            ),
          ),

        ],
      ),

    ],
    ));

  }

  Widget _walletTile(String title, String value, double width, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.montserrat(
              fs: width * 0.042,
              fw: FontWeight.w500,
              c: highlight ? Colors.green : Colors.black87,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.montserrat(
              fs: width * 0.045,
              fw: FontWeight.w600,
              c: highlight ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
