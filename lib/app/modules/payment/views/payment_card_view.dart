import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/payment/views/order_success.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              CurvedTopRightBackground(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                         IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      Text(
                        'Add New Card',
                        style: AppTextStyle.montserrat(
                          fw: FontWeight.w600,
                          fs: 20,
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
          const Divider(height: 0.8, color: Color.fromARGB(102, 205, 205, 204)),

          // Main Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardMockup(),
                  const SizedBox(height: 24),
                  _inputLabel('Card Number'),
                  _inputField('Enter Card Number', cardNumberController),
                  const SizedBox(height: 16),
                  _inputLabel('Card Holder Name'),
                  _inputField('Enter Holder Name', holderNameController),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _inputLabel('Expired'),
                            _inputField('MM/YY', expiryController),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _inputLabel('CVV Code'),
                            _inputField('CVV', cvvController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Add Button
          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              child: CustomButton(
                text: "Add Card",
                onPressed: () {
                  Get.to(() => const OrderSuccessView());
                },
              ),


            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget _cardMockup() {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.orange,
        borderRadius: BorderRadius.circular(16),
        // Optional subtle background decoration circles
        gradient: const LinearGradient(
          colors: [Color(0xFFFBAA60), Color(0xFFFFA726)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Positioned background circles for design (optional)
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Current Balance',
                    style: AppTextStyle.montserrat(
                      c: Colors.white,
                      fs: 14,
                      fw: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'VISA',
                        style: AppTextStyle.montserrat(
                          c: Colors.white,
                          fs: 20,
                          fw: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Debit',
                        style: AppTextStyle.montserrat(
                          c: Colors.white,
                          fs: 12,
                          fw: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '\$X.XXX,XX',
                style: AppTextStyle.montserrat(
                  c: Colors.white,
                  fs: 26,
                  fw: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '**** **** **** ****',
                    style: AppTextStyle.montserrat(c: Colors.white, fs: 16),
                  ),
                  Text(
                    '12/24',
                    style: AppTextStyle.montserrat(c: Colors.white, fs: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: AppTextStyle.montserrat(fw: FontWeight.w500, fs: 15),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: AppTextStyle.montserrat(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.montserrat(c: Colors.grey.shade400),
        filled: true,
        fillColor: const Color(0xFFF7F9FD),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
