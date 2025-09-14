import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/all_address_list/views/all_address_list_view.dart';
import 'package:sofo/app/modules/checkout/views/address_model.dart';
import 'package:sofo/app/modules/checkout/views/delivery_time.dart';
import 'package:sofo/app/modules/edit_address/views/edit_address_view.dart';
import 'package:sofo/app/modules/payment/views/payment_view.dart';
import '../../../custom_widgets/loder.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends StatefulWidget {
  final double totalPrice;
  final List<int> productIds;
  final List<int> quantities;

  const CheckoutView({
    super.key,
    required this.totalPrice,
    required this.productIds,
    required this.quantities,
  });

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final checkoutController = Get.put(CheckoutController());
  String? selectedPayment; // null by default

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
                      return const Center(
                        child: SizedBox(
                          height: 300,
                          child: CustomLoadingIndicator(),
                        ),
                      );
                    }

                    if (checkoutController.allAddresses.isEmpty) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_off, size: 50, color: Colors.grey),
                              const SizedBox(height: 10),
                              Text(
                                "No address found",
                                style: AppTextStyle.montserrat(
                                  fs: 14,
                                  c: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => AllAddressListView());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.orange,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text("Add Address"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: checkoutController.allAddresses.length,
                        itemBuilder: (context, index) {
                          final address = checkoutController.allAddresses[index];
                          return _addressTile(address);
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  _sectionTitle('Payment method'),
                  _paymentTile('Online Payment'),
                  _paymentTile('cod'),
                  const SizedBox(height: 10),
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
              // Validate address
              if (checkoutController.selectedAddressId.value.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Please select a shipping address",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: 14.0,
                );
                return;
              }

              // Validate payment
              if (selectedPayment == null || selectedPayment!.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Please select a payment method",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: 14.0,
                );
                return;
              }

              if (selectedPayment == "cod") {
                /// ✅ COD → Delivery Time Flow
                Get.to(() => ChooseDeliveryTimeView(
                      seledtedaddress: checkoutController.selectedAddressId.value,
                      selectedpayment: selectedPayment!,
                      productIds: widget.productIds,
                      totalPrice: widget.totalPrice,
                      quantities: widget.quantities,
                    ));
              } else {
                /// ✅ Online Payment → Direct Payment Screen
                Get.to(() => PaymentView(
                      deliveryType: "Regular",
                      selectedDate: "",
                      selectedTime: "",
                      selectedAddress: checkoutController.selectedAddressId.value,
                      selectedPayment: selectedPayment!,
                      productIds: widget.productIds,
                      totalPrice: widget.totalPrice,
                      quantities: widget.quantities,
                    ));
              }
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
    final fullAddress =
        "${address.houseNo}, ${address.roadName}, ${address.city}, ${address.state}";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Obx(
            () => Radio<String>(
              value: address.id.toString(),
              groupValue: checkoutController.selectedAddressId.value,
              activeColor: AppColor.orange,
              onChanged: (value) {
                checkoutController.selectAddressById(value!);
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.type,
                    style: AppTextStyle.montserrat(fs: 14, fw: FontWeight.w600)),
                Text(address.phone,
                    style: AppTextStyle.montserrat(
                        fs: 12, c: Colors.black.withOpacity(0.6))),
                Text(fullAddress,
                    style: AppTextStyle.montserrat(
                        fs: 12, c: Colors.black.withOpacity(0.6))),
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
            selectedPayment = value;
          });
        },
      ),
    );
  }
}
