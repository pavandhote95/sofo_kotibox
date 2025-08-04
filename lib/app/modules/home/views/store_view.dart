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

// ignore: must_be_immutable
class StoreView extends GetView<StoreController> {
  late StorelistData storeListData;

  StoreView({required this.storeListData});

  @override
  final StoreController controller = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    controller.getStoreList(storeListData.id.toString());
    controller.getStoreitemList(storeListData.id.toString());
    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: Column(
              children: [
                // AppBar-like
                Container(
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      Text(
                        'Store Details',
                        style: AppTextStyle.montserrat(
                          fs: 18,
                          fw: FontWeight.bold,
                          c: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.black),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                // Main Scrollable Area
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// Top Background and Info Section
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                color: AppColor.white,
                                child: CachedNetworkImage(
                                  imageUrl: controller.storeItem.value
                                          .storeDetails?.shopImage ??
                                      "",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.storeItem.value
                                                  .storeDetails?.shopName ??
                                              '',
                                          style: AppTextStyle.montserrat(
                                              fs: 16, fw: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: AppColor.orange),
                                            Text(
                                              ' ${controller.storeItem.value.storeDetails?.rating?.toStringAsFixed(1) ?? ""}',
                                              style: AppTextStyle.montserrat(
                                                  fs: 14, fw: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Image.asset("assets/icons/location.png",
                                            width: 25, height: 20),
                                        Text(
                                          controller.storeItem.value
                                                  .storeDetails?.address ??
                                              '',
                                          style: AppTextStyle.montserrat(
                                              fs: 14, c: AppColor.greyText),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.storeItem.value
                                                  .storeDetails?.shopTime ??
                                              '',
                                          style: AppTextStyle.montserrat(
                                              fs: 14, c: AppColor.greyText),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print(
                                                'Store ID: ${controller.storeItem.value.storeDetails?.id ?? "N/A"}');
                                            Get.to(() => StoreInformationView(
                                                  storeDetails: controller
                                                      .storeItem
                                                      .value
                                                      .storeDetails,
                                                ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: AppColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Store Info',
                                                  style:
                                                      AppTextStyle.montserrat(
                                                    fs: 13,
                                                    c: Colors.black,
                                                    fw: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Icon(Icons.arrow_forward,
                                                    size: 19),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: AppColor.greyFieldBorder,
                                      thickness: 1,
                                      height: 24,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),

                        /// Popular Items Grid Placeholder
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Popular Items',
                                    style: AppTextStyle.montserrat(
                                        fs: 16, fw: FontWeight.bold),
                                  ),
                                  // Text(
                                  //   'View all items',
                                  //   style: AppTextStyle.montserrat(fs: 14, c: AppColor.orange),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Popular items not yet implemented. Add storeItems to StoreItem model.',
                                style: AppTextStyle.montserrat(
                                  fs: 14,
                                  fw: FontWeight.w500,
                                  c: AppColor.greyText,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Popular Items Grid
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Popular Items',
                                      style: AppTextStyle.montserrat(
                                          fs: 16, fw: FontWeight.bold)),
                                  // Text('View all items',
                                  //     style: AppTextStyle.montserrat(
                                  //         fs: 14, c: AppColor.orange)),
                                ],
                              ),
                              SizedBox(height: 12),
                              Obx(() {
                                var items = controller.storeItems;
                                // Handle null or empty list
                                // Handle null or empty list
                                if (items.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 32),
                                      child: Text(
                                        "No Items Available",
                                        style: AppTextStyle.montserrat(
                                          fs: 14,
                                          fw: FontWeight.w500,
                                          c: AppColor.greyText,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                // Main GridView
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: items.length,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemBuilder: (context, index) {
                                    var item = items[index];
                                    return GestureDetector(
                                      onTap: () => Get.to(() =>
                                          ProductDetailsView(
                                              item: items[index])),
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 6,
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: AppColor.grey,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: item['image'] ?? '',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Center(
                                                  child: Text(
                                                    'No Image',
                                                    style:
                                                        AppTextStyle.montserrat(
                                                      fs: 14,
                                                      c: AppColor.greyText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item['name'] ?? '',
                                                    style:
                                                        AppTextStyle.montserrat(
                                                      fs: 13,
                                                      fw: FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  item['brand'] ?? 'No Brand',
                                                  style:
                                                      AppTextStyle.montserrat(
                                                    fs: 13,
                                                    c: AppColor.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Text(
                                                '₹${item['price'] ?? ''}',
                                                style: AppTextStyle.montserrat(
                                                  fs: 13,
                                                  c: AppColor.orange,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            GestureDetector(
                                              onTap: () {
                                                // Add to cart or buy
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: AppColor.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Buy now',
                                                    style:
                                                        AppTextStyle.montserrat(
                                                      fs: 11,
                                                      c: AppColor.white,
                                                      fw: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          /// Loader OVER Scaffold
          if (controller.isLoading.value)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Center(child: CustomLoadingIndicator()),
              ),
            ),
        ],
      );
    });
  }
}
