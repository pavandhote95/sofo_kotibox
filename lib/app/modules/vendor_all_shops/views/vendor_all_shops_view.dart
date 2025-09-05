import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/loder.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/shop_products/views/shop_products_view.dart';
import '../controllers/vendor_all_shops_controller.dart';

class VendorAllShopsView extends StatelessWidget {
  VendorAllShopsView({super.key});

  final VendorAllShopsController controller =
      Get.put(VendorAllShopsController());

  final box = GetStorage(); // local storage instance

  String limitLetters(String text, int letterLimit) {
    if (text.length <= letterLimit) {
      return text;
    } else {
      return text.substring(0, letterLimit) + "...";
    }
  }

  /// Build stars based on rating (out of 5)
  Widget buildStarRating(String rating) {
    double rate = double.tryParse(rating) ?? 0;
    List<Widget> stars = [];

    for (int i = 1; i <= 5; i++) {
      if (rate >= i) {
        stars.add(const Icon(Icons.star, color: Colors.orange, size: 14));
      } else if (rate >= i - 0.5) {
        stars.add(const Icon(Icons.star_half, color: Colors.orange, size: 14));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.orange, size: 14));
      }
    }
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text("All Shops"),
        backgroundColor: AppColor.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoadingIndicator());
        }

        if (controller.storeList.isEmpty) {
          return const Center(
            child: Text(
              "No shops available",
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
            childAspectRatio: 0.82,
          ),
          itemCount: controller.storeList.length,
          itemBuilder: (context, index) {
            var storeItem = controller.storeList[index];
            return GestureDetector(
              onTap: () {
                // Save shopId and shopName in local storage
                box.write('selectedShopId', storeItem["id"]);
                box.write('selectedShopName', storeItem["shop_name"]);

                // Navigate to shop products
                Get.to(() => ShopProductsView(
                      storeId: storeItem["id"],
                      shopName: storeItem["shop_name"],
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Shop Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: storeItem["shop_image"]?.toString() ?? "",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CustomLoadingIndicator(),
                        errorWidget: (context, url, error) => Container(
                          height: 120,
                          alignment: Alignment.center,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    /// Shop Info
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Shop Name
                          Text(
                            limitLetters(storeItem["shop_name"].toString(), 18),
                            style: AppTextStyle.montserrat(
                                fs: 14, fw: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),

                          /// Star Rating
                          buildStarRating(storeItem["rating"]?.toString() ?? "0"),
                          const SizedBox(height: 6),

                          /// Categories as chips
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: (storeItem["categories"] ?? "")
                                .toString()
                                .split(',')
                                .map<Widget>((category) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ))
                                .toList(),
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
