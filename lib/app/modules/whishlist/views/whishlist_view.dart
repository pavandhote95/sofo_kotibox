import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import 'package:sofo/app/modules/whishlist/controllers/whishlist_controller.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/text_fonts.dart';

class WishlistView extends StatelessWidget {
  final WhishlistController controller = Get.put(WhishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          CurvedTopRightBackground(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Back + Title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.black, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Wishlist",
                          style: AppTextStyle.montserrat(
                            fs: 20,
                            fw: FontWeight.bold,
                            c: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ❤️ Wishlist Items
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.wishlist.isEmpty) {
                      return Center(
                        child: Text(
                          'Your wishlist is empty',
                          style: AppTextStyle.manRope(
                            fs: 14,
                            c: AppColor.greyText,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: controller.wishlist.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = controller.wishlist[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.grey.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // 🖼️ Product Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: (item['image'] != null &&
                                        item['image'].toString().isNotEmpty)
                                    ? Image.network(
                                        item['image'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/login.jpg",
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(width: 12),

                              // 📌 Product Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'] ?? "Unknown",
                                      style: AppTextStyle.montserrat(
                                        fs: 14,
                                        fw: FontWeight.w600,
                                        c: AppColor.greyText,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹${item['price'] ?? '0'}",
                                      style: AppTextStyle.manRope(
                                        fs: 12,
                                        c: AppColor.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 🗑️ Remove Button
                              IconButton(
                                icon: Icon(Icons.delete, color: AppColor.grey),
                                onPressed: () {
                                  controller.removeFromWishlist(index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
