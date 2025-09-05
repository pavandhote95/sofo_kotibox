import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/loder.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import '../controllers/shop_products_controller.dart';

class ShopProductsView extends StatelessWidget {
  final int storeId;
  final String shopName;

  const ShopProductsView({
    super.key,
    required this.storeId,
    required this.shopName,
  });

  @override
  Widget build(BuildContext context) {
    final ShopProductsController controller =
        Get.put(ShopProductsController(storeId, shopName));

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(shopName),
        backgroundColor: AppColor.orange,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoadingIndicator());
        }

        if (controller.productList.isEmpty) {
          return const Center(
            child: Text(
              "No products available",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            var product = controller.productList[index];

            return Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// --- Product Image ---
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product["image"] ?? "",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 120,
                          alignment: Alignment.center,
                          child: const CustomLoadingIndicator(),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 120,
                          alignment: Alignment.center,
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported,
                              size: 40, color: Colors.grey),
                        ),
                      ),
                    ),

                    /// --- Product Info ---
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"] ?? "",
                            style: AppTextStyle.montserrat(
                              fs: 14,
                              fw: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "₹ ${product["price"] ?? "0"}",
                            style: AppTextStyle.montserrat(
                              fs: 13,
                              fw: FontWeight.bold,
                              c: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product["brand"] ?? "",
                            style: AppTextStyle.montserrat(
                              fs: 12,
                              fw: FontWeight.w500,
                              c: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product["about"] ?? "",
                            style: AppTextStyle.montserrat(
                              fs: 11,
                              fw: FontWeight.w400,
                              c: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
