  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
import 'package:sofo/app/modules/Dashboard/controllers/dashboard_controller.dart';

import 'package:sofo/app/routes/app_pages.dart';
  import '../../../../custom_widgets/app_color.dart';
  import '../../../../custom_widgets/custom_button.dart';
  import '../../../../custom_widgets/text_fonts.dart';
  import 'ProductDetailsController.dart';

  class ProductDetailsView extends GetView {
    final Map<String, dynamic> item; // Add item parameter to receive data

    ProductDetailsView({super.key, required this.item});
    final controller = Get.put(ProductDetailsController());

    @override
    Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      controller.setInitialPrice(item['price'].toString());

      return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: -height * 0.06,
              right: -width * 0.15,
              child: Container(
                height: height * 0.18,
                width: height * 0.23,
                decoration: BoxDecoration(
                  color: AppColor.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(height * 0.5),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(Icons.arrow_back_ios, color: Colors.black),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              item['name'] ?? 'Product Name', // Use item name
                              style: AppTextStyle.montserrat(
                                fs: 20,
                                c: Colors.black,
                                fw: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Product Image Section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColor.greyFieldBorder),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: item['image'] ?? 'https://via.placeholder.com/150', // Use item image
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Text(
                                      'No Image',
                                      style: AppTextStyle.montserrat(
                                        fs: 14,
                                        c: AppColor.greyText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),                        // Product Detail Section
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About this Product',
                                  style: AppTextStyle.montserrat(
                                    fs: 18,
                                    fw: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  item['about'] ?? 'No description available.', // Use item description if available
                                  style: AppTextStyle.montserrat(
                                    fs: 14,
                                    c: Colors.black.withOpacity(0.60),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.6),
                                  height: 30,
                                ),
                                Column(
                                  children: [
                                    buildProductDetailsRow(
                                      title: 'Brand',
                                      value: item['brand'] ?? 'No Brand',
                                    ),
                                    buildProductDetailsRow(
                                      title: 'Size',
                                      value: item['size'] ?? 'Not specified',
                                    ),
                                    Obx(() => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Quantity', style: AppTextStyle.montserrat(fs: 16)),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: controller.decrement,
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(Icons.remove, size: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                controller.quantity.value.toString(),
                                                style: AppTextStyle.montserrat(fs: 16, fw: FontWeight.bold),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: controller.increment,
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(Icons.add, size: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                    Divider(),
                                    SizedBox(height: 10),
                                    Obx(() => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total Price', style: AppTextStyle.montserrat(fs: 14)),
                                        Text(
                                          '₹${controller.totalPrice.toStringAsFixed(2)}',
                                          style: AppTextStyle.montserrat(fs: 18, fw: FontWeight.bold),
                                        ),
                                      ],
                                    )),

                                  ],
                                ),
                                SizedBox(height: 24),
                             // For Add to Cart button
Obx(() => CustomButton(
  text: 'Add to Cart',
  isLoading: controller.isLoading.value,
  onPressed: () {
    showPurchaseDialog(context, item, controller);
  },
)),



                                SizedBox(height: 8),
                            CustomButton(
  text: 'Buy Now',

  onPressed: () {
    // Navigate and remove all previous routes
    Get.offAllNamed(Routes.DASHBOARD);

    // Wait for the navigation to complete, then change tab
    Future.delayed(Duration(milliseconds: 100), () {
      Get.find<DashboardController>().changeIndex(2); // Navigate to Cart tab
    });
  },
),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget buildProductDetailsRow({
      required String title,
      required String value,
    }) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.montserrat(fs: 16, c: Colors.black87),
            ),
            Text(
              value,
              style: AppTextStyle.montserrat(
                fs: 16,
                fw: FontWeight.bold,
                c: AppColor.orange,
              ),
            ),
          ],
        ),
      );
    }

  void showPurchaseDialog(BuildContext context, Map<String, dynamic> item, ProductDetailsController controller) {
  showDialog(
    context: context,
    builder: (context) {
      final screenWidth = MediaQuery.of(context).size.width;

      return Dialog(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  // ✅ Product Image
                  Container(
                    height: 100,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: AppColor.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.network(
                      item['image'] ?? 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.chair,
                        size: 40,
                        color: AppColor.orange,
                      ),
                    ),
                  ),

                  // ✅ Product Info
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'] ?? 'Product',
                                    style: AppTextStyle.montserrat(
                                      fs: 18,
                                      fw: FontWeight.bold,
                                      c: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Select quantity you want to purchase',
                                    style: AppTextStyle.montserrat(
                                      fs: 14,
                                      c: Colors.black.withOpacity(0.54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.black),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ✅ Quantity Selector
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            color: AppColor.backgroundColor,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildQtyButton(Icons.remove, controller.decrement),
                              Text(
                                controller.quantity.value.toString().padLeft(2, '0'),
                                style: AppTextStyle.montserrat(
                                  fs: 24,
                                  fw: FontWeight.bold,
                                  c: Colors.black,
                                ),
                              ),
                              _buildQtyButton(Icons.add, controller.increment),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ✅ Price & Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price per Item",
                                style: AppTextStyle.montserrat(fs: 16, c: Colors.black87)),
                            Text(
                              "₹${controller.pricePerItem.value.toStringAsFixed(2)}",
                              style: AppTextStyle.montserrat(
                                fs: 16,
                                fw: FontWeight.bold,
                                c: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",
                                style: AppTextStyle.montserrat(
                                    fs: 18, fw: FontWeight.bold, c: Colors.black87)),
                            Text(
                              "₹${controller.totalPrice.toStringAsFixed(2)}",
                              style: AppTextStyle.montserrat(
                                fs: 18,
                                fw: FontWeight.bold,
                                c: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ✅ Confirm Button
                       CustomButton(
  height: 40,
  text: 'Confirm',
  borderRadius: 12,
  isLoading: controller.isLoading.value,
  onPressed: () {
    final productId = item['id'] ?? 0;
    controller.sendData(productId: productId); // ✅ Quantity already included
  },
),

                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.black12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: AppTextStyle.montserrat(
                                fs: MediaQuery.of(context).size.width * 0.045,
                                c: Colors.black,
                                fw: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      );
    },
  );
}

    Widget _buildQtyButton(IconData icon, VoidCallback onPressed) {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.black),
          onPressed: onPressed,
        ),
      );
    }
  }