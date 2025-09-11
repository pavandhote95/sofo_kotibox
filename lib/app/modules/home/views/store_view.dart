import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/modules/home/views/ProductDetails/product_details_view.dart';
import 'package:sofo/app/modules/home/views/store_information.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/loder.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../data/store_list.dart';
import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  final StorelistData storeListData;

  StoreView({required this.storeListData});

  @override
  final StoreController controller = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    controller.getStoreList(storeListData.id.toString());
    controller.getStoreitemList(storeListData.id.toString());

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Store Details',
          style: AppTextStyle.montserrat(fs: 18, fw: FontWeight.bold, c: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Store Info Section
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          color: AppColor.white,
                          child: CachedNetworkImage(
                            imageUrl: controller.storeItem.value.storeDetails?.shopImage ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(child: CustomLoadingIndicator()),
                            errorWidget: (context, url, error) => Center(child: CustomLoadingIndicator()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.storeItem.value.storeDetails?.shopName ?? '',
                                    style: AppTextStyle.montserrat(fs: 16, fw: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: AppColor.orange),
                                      Text(
                                        ' ${controller.storeItem.value.storeDetails?.rating?.toStringAsFixed(1) ?? ""}',
                                        style: AppTextStyle.montserrat(fs: 14, fw: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.asset("assets/icons/location.png", width: 25, height: 20),
                                  Text(
                                    controller.storeItem.value.storeDetails?.address ?? '',
                                    style: AppTextStyle.montserrat(fs: 14, c: AppColor.greyText),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.storeItem.value.storeDetails?.shopTime ?? '',
                                    style: AppTextStyle.montserrat(fs: 14, c: AppColor.greyText),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => StoreInformationView(
                                        storeDetails: controller.storeItem.value.storeDetails,
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Store Info',
                                            style: AppTextStyle.montserrat(fs: 13, c: Colors.black, fw: FontWeight.w600),
                                          ),
                                          SizedBox(width: 2),
                                          Icon(Icons.arrow_forward, size: 19),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: AppColor.greyFieldBorder, thickness: 1, height: 24)
                            ],
                          ),
                        ),
                      ],
                    );
                  }),

                  /// Popular Items Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text('Popular Items', style: AppTextStyle.montserrat(fs: 22, fw: FontWeight.bold)),
                      ],
                    ),
                  ),

                  /// Search Box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: TextField(
                      onChanged: (value) => controller.searchItems(value),
                      decoration: InputDecoration(
                        hintText: "Search products...",
                        prefixIcon: Icon(Icons.search, color: AppColor.greyText),
                        filled: true,
                        fillColor: AppColor.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: AppColor.greyFieldBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: AppColor.greyFieldBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: AppColor.orange),
                        ),
                      ),
                    ),
                  ),

                  /// Items Grid
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(() {
                      var items = controller.filteredItems;

                      if (items.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Text(
                              "No Items Found",
                              style: AppTextStyle.montserrat(fs: 14, fw: FontWeight.w500, c: AppColor.greyText),
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 189,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) {
                          var item = items[index];

                          return Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Product Image with Favorite
                                Expanded(
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.storage.write('last_product_id', item['id']);
                                          Get.to(() => ProductDetailsView(item: item));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: AppColor.grey,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              imageUrl: item['image'] ?? '',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(child: CustomLoadingIndicator()),
                                              errorWidget: (context, url, error) => Center(
                                                child: Text(
                                                  'No Image',
                                                  style: AppTextStyle.montserrat(fs: 12, c: AppColor.greyText),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 6,
                                        right: 6,
                                        child: Obx(() {
                                          bool isFav = controller.wishlistStatus[item['id']] ?? false;
                                          return GestureDetector(
                                            onTap: () {
                                              controller.toggleWishlist(item['id']);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.9),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                                                ],
                                              ),
                                              child: Icon(
                                                isFav ? Icons.favorite : Icons.favorite_border,
                                                color: isFav ? AppColor.orange : AppColor.greyText,
                                                size: 18,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 8),

                                // Name & Price
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['name'] ?? 'Item Name',
                                        style: AppTextStyle.montserrat(fs: 13, fw: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "₹${item['price'] ?? '0'}",
                                      style: AppTextStyle.montserrat(fs: 13, fw: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 6),

                                // Buy Now Button
                                GestureDetector(
                                  onTap: () {
                                    controller.storage.write('last_product_id', item['id']);
                                    Get.to(() => ProductDetailsView(item: item));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColor.orange,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Buy now',
                                        style: AppTextStyle.montserrat(fs: 12, c: AppColor.white, fw: FontWeight.bold),
                                      ),
                                    ),
                                  ),
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
          )
        ],
      ),
    );
  }
}
