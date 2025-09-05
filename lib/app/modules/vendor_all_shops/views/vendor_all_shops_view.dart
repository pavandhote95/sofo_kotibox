import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/loder.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/home/views/store_view.dart';
import 'package:sofo/app/modules/vendor_all_shops/controllers/vendor_all_shops_controller.dart';

class VendorAllShopsView extends StatelessWidget {
  VendorAllShopsView({super.key});

  final VendorAllShopsController controller =
      Get.put(VendorAllShopsController());

  String limitLetters(String text, int letterLimit) {
    if (text.length <= letterLimit) {
      return text;
    } else {
      return text.substring(0, letterLimit) + "...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text("All Shops"),
        backgroundColor: AppColor.orange,
        foregroundColor: Colors.white,
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
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            childAspectRatio: 0.99,
          ),
          itemCount: controller.storeList.length,
          itemBuilder: (context, index) {
            var storeItem = controller.storeList[index];
            return GestureDetector(
              onTap: () {
                print("SHOP CLICKED: ${storeItem["shop_name"]}");
                Get.to(() => StoreView(storeListData: storeItem));
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// --- Shop Image ---
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: storeItem["shop_image"]?.toString() ?? "",
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: const CustomLoadingIndicator(),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 100,
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

                      /// --- Shop Info ---
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              limitLetters(
                                  storeItem["shop_name"].toString(), 14),
                              style: AppTextStyle.montserrat(
                                fs: 14,
                                fw: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "⭐ ${storeItem["rating"] ?? "0"}",
                              style: AppTextStyle.montserrat(
                                fs: 12,
                                fw: FontWeight.w500,
                                c: Colors.orange,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              storeItem["categories"]?.toString() ?? "",
                              style: AppTextStyle.montserrat(
                                fs: 11,
                                fw: FontWeight.w500,
                                c: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
