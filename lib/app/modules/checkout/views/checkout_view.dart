import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/checkout/views/address_model.dart';
import 'package:sofo/app/modules/checkout/views/delivery_time.dart';
import 'package:sofo/app/modules/edit_address/views/edit_address_view.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends StatefulWidget {
  final double totalPrice;
  final List<int> productIds;

  const CheckoutView({
    super.key,
    required this.totalPrice,
    required this.productIds,
  });

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final checkoutController = Get.put(CheckoutController());

  String selectedAddressType = 'Home';
  String selectedPayment = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      const Spacer(),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Shipping to'),
                  Obx(() {
                    if (checkoutController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        if (checkoutController.homeAddress.value != null)
                          _addressTile(checkoutController.homeAddress.value!),
                        if (checkoutController.officeAddress.value != null)
                          _addressTile(checkoutController.officeAddress.value!),
                      ],
                    );
                  }),
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
                    onTap: () {},
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
              Get.to(() => const ChooseDeliveryTimeView());
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

  Widget _addressTile(AddressModel address) {
    final type = address.type;
    final phone = address.phone;
    final fullAddress = "${address.houseNo}, ${address.roadName}, ${address.city}, ${address.state}";

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
            value: type,
            groupValue: selectedAddressType,
            activeColor: AppColor.orange,
            onChanged: (value) async {
              setState(() {
                selectedAddressType = value!;
              });

              // Print selected address
              print('--- Selected Address ---');
              print('ID: ${address.id}');
              print('Type: ${address.type}');
              print('Phone: ${address.phone}');
              print('City: ${address.city}');
              print('State: ${address.state}');
              print('Pincode: ${address.pincode}');

              // Call API
              await checkoutController.callShippingEditApi(address);
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: AppTextStyle.montserrat(fs: 14, fw: FontWeight.w600)),
                Text(phone, style: AppTextStyle.montserrat(fs: 12, c: Colors.black.withOpacity(0.6))),
                Text(fullAddress, style: AppTextStyle.montserrat(fs: 12, c: Colors.black.withOpacity(0.6))),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
            onPressed: () {
              Get.to(() => EditAddressView(initialData: {
                'id': address.id.toString(),
                'type': address.type,
                'full_name': address.fullName,
                'road_name': address.roadName,
                'house_no': address.houseNo,
                'city': address.city,
                'state': address.state,
                'pincode': address.pincode.toString(),
                'phone': address.phone,
              }));
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
