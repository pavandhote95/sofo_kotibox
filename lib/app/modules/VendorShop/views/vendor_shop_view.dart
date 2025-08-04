import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendor_shop_controller.dart';

class VendorShopView extends StatelessWidget {
  final VendorShopController controller = Get.put(VendorShopController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),
          Column(
            children: [
              CustomAppBar(title: 'My Shop', onActionTap: null),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => buildDetail('Shop Name', controller.shopName.value)),
                      Obx(() => buildDetail('GST Number', controller.gstNumber.value)),
                      Obx(() => buildDetail('PAN Number', controller.panNumber.value)),
                      Obx(() => buildDetail('TAN Number', controller.tanNumber.value)),
                      Obx(() => buildDetail('Address', controller.address.value)),

                      const SizedBox(height: 10),
                      Text(
                        'Categories:',
                        style: AppTextStyle.montserrat(
                          fs: width * 0.045,
                          fw: FontWeight.bold,
                          c: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Obx(() => Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: controller.selectedCategories
                            .map((cat) => Chip(label: Text(cat, style: AppTextStyle.montserrat(fs: width * 0.04),)))
                            .toList(),
                      )),
                      Obx(() {
                        if (controller.selectedCategories.contains('Other')) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: buildDetail('Other Category Detail', controller.otherCategoryDetail.value),
                          );
                        }
                        return const SizedBox();
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          text: '$label:\n',
          style: AppTextStyle.montserrat(
            fs: 16,
            fw: FontWeight.bold,
            c: Colors.black,
          ),
          children: [
            TextSpan(
              text: value.isNotEmpty ? value : 'Not provided',
              style: AppTextStyle.montserrat(
                fs: 15,
                c: Colors.black87,
                fw: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
