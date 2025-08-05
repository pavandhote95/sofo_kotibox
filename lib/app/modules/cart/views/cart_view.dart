import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/checkout/views/checkout_view.dart';
import '../../../custom_widgets/loder.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  CartView({super.key}) {
    Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchCartItems();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: RefreshIndicator(
        color: AppColor.orange,
        onRefresh: () async {
          await controller.fetchCartItems();
        },

        child: Stack(
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
            Column(
              children: [
                const SizedBox(height: 45),
                Center(
                  child: Text(
                    'My Cart',
                    style: AppTextStyle.montserrat(fs: 20, fw: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CustomLoadingIndicator());
                      }
                      if (controller.cartItems.isEmpty) {
                        return Center(
                          child: Text(
                            "No item Available",
                            style: AppTextStyle.montserrat(
                              fs: width * 0.045,
                              c: Colors.black,
                              fw: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: controller.cartItems.length + 1,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (context, index) {
                          if (index < controller.cartItems.length) {
                            final item = controller.cartItems[index];
                            return buildCartItem(item, index, width);
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                summaryRow(
                                  "Items",
                                  "₹${controller.totalItemPrice.toStringAsFixed(2)}",
                                  width,
                                ),
                                summaryRow(
                                  "Shipping Fee",
                                  "₹${controller.shippingFee.toStringAsFixed(2)}",
                                  width,
                                ),
                                const Divider(),
                                Obx(() {
                                  return summaryRow(
                                    "Total",
                                    "₹${controller.totalPrice.toStringAsFixed(2)}",
                                    width,
                                    bold: true,
                                  );
                                }),
                                const SizedBox(height: 16),
                                CustomButton(
                                  text: 'Check out',
                                  onPressed: () {
                                    controller.checkout();

                                  },
                                ),
                              ],
                            );
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(Map<String, dynamic> item, int index, double width) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item['product_image']?.toString() ?? 'https://via.placeholder.com/60',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.image, size: 60, color: AppColor.grey),
            ),
          ),                const SizedBox(width: 5),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['product_name']?.toString() ?? 'Unknown Product',
                  style: AppTextStyle.montserrat(
                    fs: width * 0.04,
                    fw: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${(double.tryParse(item['product_price'].toString()) ?? 0.0).toStringAsFixed(2)}',
                  style: AppTextStyle.montserrat(
                    fs: width * 0.032,
                    c: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Obx(() => Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: AppColor.orange,
                    ),
                    onPressed: () => controller.decrement(index),
                  ),
                  Text(
                    controller.quantities[index].toString(),
                    style: AppTextStyle.montserrat(fs: width * 0.035),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: AppColor.orange,
                    ),
                    onPressed: () => controller.increment(index),
                  ),
                ],
              )),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "Remove Item",
                    middleText:
                    "Are you sure you want to remove ${item['product_name']} from your cart?",
                    textConfirm: "Yes",
                    textCancel: "No",
                    middleTextStyle:   AppTextStyle.montserrat(
                      fs: width * 0.04,
                      fw: FontWeight.w500,
                    ),
                    titleStyle: AppTextStyle.montserrat(
                      fs: width * 0.04,
                      fw: FontWeight.w200,
                    ),
                    confirmTextColor: Colors.white,
                    buttonColor: AppColor.orange,
                    onConfirm: () {
                      controller.deleteCartItem(index, item['id']);
                      Get.back();
                    },
                  );
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget summaryRow(String label, String value, double width, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.montserrat(fs: width * 0.035),
          ),
          Text(
            value,
            style: AppTextStyle.montserrat(
              fs: width * 0.035,
              fw: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}