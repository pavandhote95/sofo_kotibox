import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../custom_widgets/app_color.dart';
import '../../../../custom_widgets/text_fonts.dart';
import '../../../home/controllers/home_controller.dart';
import '../../controllers/select_location_controller.dart';
import '../location/select_location_map.dart';
import '../../../../custom_widgets/snacbar.dart';

class SelectLocationView extends StatelessWidget {
  final SelectLocationController controller = Get.put(SelectLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: false,
        leading:       IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
        elevation: 0,
        title: Text(
          'Select Location',
          style: AppTextStyle.montserrat(
            fs: 16,
            fw: FontWeight.bold,
            c: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final homeController = Get.find<HomeController>();

        return homeController.isLoading.value
            ? Center(child: CircularProgressIndicator(color: AppColor.orange))
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Address',
                    hintStyle: AppTextStyle.montserrat(
                      fs: 13,
                      fw: FontWeight.w400,
                      c: AppColor.greyHint,
                    ),
                    filled: true,
                    fillColor: AppColor.grey.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: AppColor.greyBarIcon),
                  ),
                ),
                const SizedBox(height: 20),

                locationOptionTile(
                  icon: Icons.my_location,
                  label: 'Use my Current Location',
                  iconColor: AppColor.orange,
                  textColor: AppColor.orange,
                  onTap: () async {
                    homeController.isLoading.value = true;
                    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

                    if (!serviceEnabled) {
                      await Geolocator.openLocationSettings();
                      Future.delayed(const Duration(seconds: 2), () async {
                        if (await Geolocator.isLocationServiceEnabled()) {
                          await homeController.fetchLocationAndAddress();
                          if (homeController.currentPosition.value != null) {
                            Utils.showToast("Location fetched successfully!");
                            Get.back();
                          }
                        } else {
                          Utils.showErrorToast("Please enable location to continue");
                        }
                        homeController.isLoading.value = false;
                      });
                    } else {
                      await homeController.fetchLocationAndAddress();
                      if (homeController.currentPosition.value != null) {
                        Utils.showToast("Location fetched successfully!");
                        Get.back();
                      }
                      homeController.isLoading.value = false;
                    }
                  },
                ),

                locationOptionTile(
                  icon: Icons.add,
                  label: 'Add New Address',
                  iconColor: AppColor.orange,
                  textColor: AppColor.orange,
                  onTap: () => Get.to(() => SelectLocationMap()),
                  showArrow: true,
                ),

                const SizedBox(height: 24),

                Text(
                  'Saved Addresses',
                  style: AppTextStyle.montserrat(
                    fs: 14,
                    fw: FontWeight.w600,
                    c: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                addressCard(
                  title: 'Home',
                  address: '34, Jai Nagar (Neelkhant Mahadev Mandir ke paas), Murlipura, Vishwakarma Industrial Area, Jaipur',
                  icon: Icons.home,
                  onMenuTap: () {},
                ),

                const SizedBox(height: 12),

                addressCard(
                  title: 'Other',
                  address: 'Wry, 03, Raghunath Colony, Jhotwara Industrial Area, Jhotwara, Jaipur, Rajasthan 302012, India',
                  icon: Icons.location_on,
                  onMenuTap: () {},
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget locationOptionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
    bool showArrow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColor.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.montserrat(
                  fs: 13,
                  fw: FontWeight.w600,
                  c: textColor,
                ),
              ),
            ),
            if (showArrow)
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColor.greyBarIcon),
          ],
        ),
      ),
    );
  }

  Widget addressCard({
    required String title,
    required String address,
    required IconData icon,
    required VoidCallback onMenuTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColor.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.montserrat(
                    fs: 13,
                    fw: FontWeight.w600,
                    c: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  address,
                  style: AppTextStyle.montserrat(
                    fs: 12,
                    fw: FontWeight.w400,
                    c: AppColor.greyText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, size: 18, color: AppColor.greyBarIcon),
            onPressed: onMenuTap,
          ),
        ],
      ),
    );
  }
}
