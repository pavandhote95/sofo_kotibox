import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../custom_widgets/app_color.dart';
import '../../../../custom_widgets/text_fonts.dart';
import '../../controllers/select_location_controller.dart';
import '../../../home/views/location/add_address.dart';

class SelectLocationMap extends StatelessWidget {
  SelectLocationMap({super.key});
  final controller = Get.put(SelectLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading:       IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
        title: Text(
          'Select Your Location',
          style: AppTextStyle.montserrat(
            fs: 18,
            fw: FontWeight.w600,
            c: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColor.greyFieldBorder,
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for apartment, street name...",
                    hintStyle: AppTextStyle.montserrat(
                      fs: 14,
                      fw: FontWeight.w500,
                      c: AppColor.greyText,
                    ),
                    icon: Icon(Icons.search, color: AppColor.greyText),
                  ),
                  onChanged: (value) {
                    // TODO: Add location search/autocomplete
                  },
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.mapCenter.value,
                      zoom: 16,
                    ),
                    onMapCreated: controller.onMapCreated,
                    onCameraMove: controller.onCameraMove,
                    onCameraIdle: controller.onCameraIdle,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                  const Center(
                    child: Icon(Icons.location_pin,
                        size: 50, color: Colors.red),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.place, color: AppColor.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Obx(() => Text(
                            controller.currentAddress.value,
                            style: AppTextStyle.montserrat(
                              fs: 14,
                              fw: FontWeight.w600,
                              c: Colors.black,
                            ),
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.orange,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (kDebugMode) {
                          print(
                              "Confirmed: ${controller.mapCenter.value} (${controller.currentAddress.value})");
                        }
                        Get.to(() => AddAddressDetailsView());
                      },
                      child: Text(
                        "Confirm Location",
                        style: AppTextStyle.montserrat(
                          fs: 14,
                          fw: FontWeight.bold,
                          c: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
