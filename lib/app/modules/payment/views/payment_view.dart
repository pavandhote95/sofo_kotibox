import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/modules/payment/views/payment_card_view.dart';
import 'package:sofo/app/modules/payment/controllers/payment_controller.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';

class PaymentView extends GetView<PaymentController> {
  final String deliveryType;
  final String selectedDate;
  final String selectedTime;
  final String selectedAddress;
  final String selectedPayment;
  final double totalPrice;
  final List<int> productIds;

  PaymentView({
    super.key,
    required this.deliveryType,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedAddress,
    required this.selectedPayment,
    required this.totalPrice,
    required this.productIds,
  }) {
    Get.put(PaymentController());
  }

  final List<Map<String, dynamic>> paymentOptions = [
    {'image': 'assets/icons/wallet.png', 'title': 'Wallet'},
    {'image': 'assets/icons/apple.png', 'title': 'Apple Pay'},
    {'image': 'assets/icons/stripe.png', 'title': 'Stripe'},
    {'image': 'assets/icons/asian_bank.png', 'title': 'Asian Bank'},
  ];

  Widget buildOption({
    required int index,
    required String image,
    required String title,
  }) {
    return GetBuilder<PaymentController>(
      builder: (controller) {
        final isSelected = controller.selectedIndex == index;
        return GestureDetector(
          onTap: () => controller.selectPayment(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.orange.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColor.orange : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: index == 3 ? 34 : 22,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTextStyle.montserrat(
                    fs: 14,
                    fw: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  Icon(Icons.check_circle, color: AppColor.orange),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Orange curved header
          Stack(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      Text(
                        'Payment',
                        style: AppTextStyle.montserrat(
                          fs: 20,
                          fw: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // const SizedBox(height: 20),
          //
          // // Display delivery details (optional)
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Delivery Details',
          //         style: AppTextStyle.montserrat(
          //           fs: 16,
          //           fw: FontWeight.w600,
          //           c: Colors.black,
          //         ),
          //       ),
          //       const SizedBox(height: 10),
          //       Text(
          //         'Delivery Type: $deliveryType',
          //         style: AppTextStyle.montserrat(fs: 14),
          //       ),
          //       if (deliveryType == 'Scheduled') ...[
          //         Text(
          //           'Date: $selectedDate',
          //           style: AppTextStyle.montserrat(fs: 14),
          //         ),
          //         Text(
          //           'Time: $selectedTime',
          //           style: AppTextStyle.montserrat(fs: 14),
          //         ),
          //       ],
          //       Text(
          //         'Address: $selectedAddress',
          //         style: AppTextStyle.montserrat(fs: 14),
          //       ),
          //       Text(
          //         'Total Price: \$${totalPrice.toStringAsFixed(2)}',
          //         style: AppTextStyle.montserrat(fs: 14),
          //       ),
          //       Text(
          //         'Product IDs: $productIds',
          //         style: AppTextStyle.montserrat(fs: 14),
          //       ),
          //     ],
          //   ),
          // ),
          //
          // const SizedBox(height: 20),

          // Header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Select Payment',
                  style: AppTextStyle.montserrat(
                    fs: 16,
                    fw: FontWeight.w600,
                    c: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  'Add Card',
                  style: AppTextStyle.montserrat(
                    fs: 16,
                    fw: FontWeight.w500,
                    c: AppColor.orange,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Payment options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                buildOption(index: 0, image: 'assets/icons/wallet.png', title: 'Wallet'),
                buildOption(index: 1, image: 'assets/icons/apple.png', title: 'Apple Pay'),
                buildOption(index: 2, image: 'assets/icons/stripe.png', title: 'Stripe'),
                buildOption(index: 3, image: 'assets/icons/asian_bank.png', title: 'Asian Bank'),
              ],
            ),
          ),

          const Spacer(),

          // Confirm Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: CustomButton(
                text: "Confirm",
                onPressed: () {
                  // Pass data to AddCardView if needed
                  Get.to(() => AddCardView(

                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}