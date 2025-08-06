import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/loder.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/add_address/views/add_address_view.dart';
import 'package:sofo/app/modules/all_address_list/controllers/all_address_list_controller.dart';
import 'package:sofo/app/modules/edit_address/views/edit_address_view.dart';

class AllAddressListView extends StatelessWidget {
  AllAddressListView({super.key});
  final controller = Get.put(AllAddressListController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Positioned(
            top: -height * 0.06,
            right: -width * 0.15,
            child: Container(
              height: height * 0.15,
              width: height * 0.23,
              decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(height * 0.2),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: () => Get.back(),
                    ),
                    const Spacer(),
                    Text(
                      'My Addresses',
                      style: AppTextStyle.montserrat(
                        fs: 20,
                        fw: FontWeight.w600,
                        c: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 24),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CustomLoadingIndicator());
                  } else if (controller.addressList.isEmpty) {
                    return const Center(child: Text("No addresses found."));
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                      child: ListView.builder(
                        itemCount: controller.addressList.length,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (context, index) {
                          final address = controller.addressList[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_outlined, color: Colors.redAccent),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address['type'] ?? 'Label',
                                        style: AppTextStyle.montserrat(
                                          fs: 14,
                                          fw: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        address['phone'] ?? '',
                                        style: AppTextStyle.montserrat(
                                          fs: 12,
                                          c: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '${address['house_no']}, ${address['road_name']}, ${address['city']}, ${address['state']} - ${address['pincode']}',
                                        style: AppTextStyle.montserrat(
                                          fs: 12,
                                          c: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.grey),
                                      onPressed: () {
                                      Get.to(() => EditAddressView(initialData: {
  'address_id': '2',
  'type': 'Office',
  'full_name': 'Shobha Kumari',
  'road_name': '124',
  'house_no': '25',
  'city': 'Patna',
  'state': 'Bihar',
  'pincode': '8000020',
  'phone': '99000007',
}));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: "Delete Address",
                                          middleText: "Are you sure you want to delete this address?",
                                          textConfirm: "Yes",
                                          textCancel: "No",
                                          confirmTextColor: Colors.white,
                                          buttonColor: AppColor.orange,
                                          onConfirm: () {
                         
                                            Get.back();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: CustomButton(
                    text: 'Add New Address',
                    onPressed: () {
                      Get.to(() => AddAddressView());
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
