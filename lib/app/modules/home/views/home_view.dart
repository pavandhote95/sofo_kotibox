  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:get/get.dart';
  import 'package:sofo/app/custom_widgets/curved_top_container.dart';
  import 'package:sofo/app/modules/account/controllers/account_controller.dart';
  import 'package:sofo/app/modules/home/views/store_view.dart';
import 'package:sofo/app/modules/whishlist/views/whishlist_view.dart';

  import '../../../custom_widgets/app_color.dart';
  import '../../../custom_widgets/loder.dart';
  import '../../../custom_widgets/text_fonts.dart';
  import '../../notification/views/notification_view.dart';
  import '../../searching/views/searching_view.dart';
  import '../controllers/home_controller.dart';
  import 'bottom_sheet.dart';
  import 'location/select_location.dart';

  class HomeView extends GetView<HomeController> {
    @override
    HomeController controller = Get.put(HomeController());

    // ✅ Use existing AccountController
    final AccountController accountController = Get.put(AccountController());


    @override
    Widget build(BuildContext context) {
  String limitLetters(String text, int letterLimit) {
    if (text.length <= letterLimit) {
      return text; // अगर text chhota hai to pura dikhao
    } else {
      return text.substring(0, letterLimit) + "...";
    }
  }

      String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);

  }

      return Obx(() {
        if (controller.storeCategory.isEmpty) {
          return const Center(child: CustomLoadingIndicator());
        }
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: DefaultTabController(
            length: controller.storeCategory.length,
            child: RefreshIndicator(
              color: AppColor.orange,
              onRefresh: () async {
                await controller.getCategoryName();
                await accountController.fetchUserProfile(); // 🔄 refresh profile too
              },
              child: Scaffold(
                backgroundColor: AppColor.backgroundColor,
                body: Stack(
                  children: [
                    CurvedTopRightBackground(),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// --- Header Section ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Back",
                                      style: AppTextStyle.montserrat(
                                        fs: 13,
                                        c: AppColor.greyText,
                                        fw: FontWeight.w400,
                                      ),
                                    ),
                                    // ✅ Show profile name
      Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Text(
          accountController.name.value.isNotEmpty
              ? "Hi, ${capitalize(accountController.name.value)}!"
              : "Loading...",
          key: ValueKey(accountController.name.value),
          style: AppTextStyle.montserrat(
            fs: 18,
            fw: FontWeight.w600,
          ),
        ),
      ),
  ),

                                  ],
                                ),
                              Row(
  children: [
    // 🔍 Search
    GestureDetector(
      onTap: () {
        Get.to(() => SearchingView());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(
          CupertinoIcons.search,
          size: 20,
        ),
      ),
    ),

    const SizedBox(width: 12),

    // 🔔 Notification
    GestureDetector(
      onTap: () {
        Get.to(() => NotificationView());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(
          CupertinoIcons.bell,
          size: 20,
        ),
      ),
    ),

    const SizedBox(width: 12),

    // ❤️ Wishlist
   GestureDetector(
  onTap: () {
    Get.to(() => WishlistView());
  },
  child: Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey.shade300,
      ),
      shape: BoxShape.circle,
      color: Colors.white,
    ),
    child: const Icon(
      CupertinoIcons.heart,
      size: 20,
    ),
  ),
),

  ],
)

                             
                              ],
                            ),

                            const SizedBox(height: 10),

                            /// --- Location Row ---
                            Material(
                              elevation: 0.5,
                              borderRadius: BorderRadius.circular(18),
                              color: AppColor.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(SelectLocationView());
                                      },
                                      child: Image.asset(
                                        "assets/icons/location.png",
                                        width: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(SelectLocationView());
                                        },
                                        child: Obx(
                                          () => Text(
                                            controller.currentAddress.value
                                                    .isNotEmpty
                                                ? controller.currentAddress.value
                                                : "Fetching location...",
                                            style: AppTextStyle.montserrat(
                                              fs: 13,
                                              c: AppColor.greyText,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () {
                                        showFilterBottomSheet(context);
                                      },
                                      child: Image.asset(
                                        "assets/icons/sotring_icon.png",
                                        width: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            /// --- TabBar ---
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TabBar(
                                isScrollable: true,
                                tabAlignment: TabAlignment.start,
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                indicatorPadding: EdgeInsets.zero,
                                labelColor: AppColor.orange,
                                unselectedLabelColor: AppColor.greyText,
                                labelStyle: AppTextStyle.montserrat(
                                    fs: 14, fw: FontWeight.w600),
                                unselectedLabelStyle:
                                    AppTextStyle.montserrat(fs: 14),
                                indicatorColor: AppColor.orange,
                                tabs: controller.storeCategory.map((category) {
                                  return Tab(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.network(
                                            category.image ?? '',
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                              Icons.image_not_supported,
                                              size: 30,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          category.name ?? '',
                                          style: AppTextStyle.montserrat(fs: 10),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onTap: (index) {
                                  final selectedId =
                                      controller.storeCategory[index].id
                                          .toString();
                                  controller.selectedCategoryId.value = selectedId;
                                  controller.getStoreList(selectedId);
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// --- Store List ---
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  Text(
                                    "Total Stores",
                                    style: AppTextStyle.montserrat(
                                      fs: 16,
                                      fw: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(() {
                                    var storeData =
                                        controller.storeList.value.data;

                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: storeData.length,
                                      itemBuilder: (context, index) {
                                        var storeItem = storeData[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(() => StoreView(
                                                  storeListData: storeItem,
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Material(
                                              elevation: 4,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(5),
                                                        topLeft:
                                                            Radius.circular(5),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: storeItem
                                                            .shopImage
                                                            .toString(),
                                                        height: 180,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Container(
                                                          height: 180,
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              Center(child: CustomLoadingIndicator()),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          height: 180,
                                                          alignment:
                                                              Alignment.center,
                                                          color: Colors.grey[200],
                                                          child: const Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            size: 40,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                        Text(
    limitLetters(storeItem.shopName.toString(), 15), // 🔹 2 letters + "..."
    style: AppTextStyle.montserrat(
      fs: 15,
      fw: FontWeight.w600,
    ),
  ),

                                                              const Spacer(),
                                                              Text(
                                                                storeItem
                                                                    .categories
                                                                    .toString(),
                                                                style: AppTextStyle
                                                                    .montserrat(
                                                                  fs: 10,
                                                                  fw: FontWeight
                                                                      .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Shop Time: ${storeItem.shoptime}",
                                                                style: AppTextStyle
                                                                    .montserrat(
                                                                  fs: 12,
                                                                  fw: FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                "Rating: ${storeItem.rating}",
                                                                style: AppTextStyle
                                                                    .montserrat(
                                                                  fs: 12,
                                                                  fw: FontWeight
                                                                      .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 6),
                                                          Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .location_on,
                                                                    size: 20,
                                                                    color: AppColor
                                                                        .orange,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    storeItem
                                                                        .address
                                                                        .toString(),
                                                                    style: AppTextStyle
                                                                        .montserrat(
                                                                      fs: 13,
                                                                      c: AppColor
                                                                          .orange,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.person,
                                                                    size: 20,
                                                                    color: AppColor
                                                                        .orange,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    storeItem
                                                                        .userName
                                                                        .toString(),
                                                                    style: AppTextStyle
                                                                        .montserrat(
                                                                      fs: 13,
                                                                      c: AppColor
                                                                          .orange,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
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
            ),
          ),
        );
      });
    }
  }
