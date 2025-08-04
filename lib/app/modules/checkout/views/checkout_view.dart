import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/modules/checkout/views/delivery_time.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedAddress = 'Home';
  String selectedPayment = 'Credit Card';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Custom Curved Header with Title
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
              // Back button & title
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                        IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      Text(
                        'Checkout',
                        style: AppTextStyle.montserrat(
                          fs: 20,
                          fw: FontWeight.w600,
                          c: Colors.black,
                        ),
                      ),
                      const Spacer(), // Center title
                      const SizedBox(width: 24), // to balance back button space
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Shipping to'),
                  _addressTile('Home'),
                  _addressTile('Office'),
                  const SizedBox(height: 20),
                  _sectionTitle('Payment method'),
                  _paymentTile('Credit Card'),
                  _paymentTile('Paypal'),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.add_circle, color: AppColor.orange),
                    title: Text(
                      'Add New Card',
                      style: AppTextStyle.montserrat(
                        fs: 14,
                        fw: FontWeight.w500,
                        c: AppColor.orange,
                      ),
                    ),
                    onTap: () {
                      // handle add card
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: CustomButton(
            onPressed: () {
              Get.to(
                () => const ChooseDeliveryTimeView(),
              ); // or Get.off if you want to remove curre
          
              // handle complete order
            },
            text: 'Complete Order',
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: AppTextStyle.montserrat(fs: 16, fw: FontWeight.w600),
      ),
    );
  }

  Widget _addressTile(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: label,
            groupValue: selectedAddress,
            activeColor: AppColor.orange,
            onChanged: (value) {
              setState(() {
                selectedAddress = value!;
              });
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyle.montserrat(fs: 14, fw: FontWeight.w600),
                ),
                Text(
                  "(+88) 5446456789",
                  style: AppTextStyle.montserrat(
                    fs: 12,
                    c: Colors.black.withOpacity(0.6),
                  ),
                ),
                Text(
                  "Michigan, New York City",
                  style: AppTextStyle.montserrat(
                    fs: 12,
                    c: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
            onPressed: () {
              // handle edit
            },
          ),
        ],
      ),
    );
  }

  Widget _paymentTile(String label) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: AppTextStyle.montserrat(fs: 14)),
      leading: Radio<String>(
        value: label,
        groupValue: selectedPayment,
        activeColor: AppColor.orange,
        onChanged: (value) {
          setState(() {
            selectedPayment = value!;
          });
        },
      ),
    );
  }
}
