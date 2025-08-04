import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';

class FilterBottomSheetController extends GetxController {
  var selectedSortIndex = 0.obs;
  var selectedDeliveryIndex = (-1).obs;
  var priceRange = const RangeValues(25, 85).obs;

  List<String> get sortOptions => [
    "Lowest Price",
    "Medium Price",
    "In Stock",
    "Highest Price",

    "Discounted Items",
  ];

  List<String> get deliveryOptions => [
    "2 Hours",
    "3 Hours",
    "4 Hours",
    "5 Hours",
  ];
}

void showFilterBottomSheet(BuildContext context) {
  final controller = Get.put(FilterBottomSheetController());

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SafeArea(child: _sectionHeader("Sort By")),
              const SizedBox(height: 12),
              Obx(() {
                return Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                    controller.sortOptions.length,
                    (index) => _pill(
                      label: controller.sortOptions[index],
                      isSelected: controller.selectedSortIndex.value == index,
                      onTap: () => controller.selectedSortIndex.value = index,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 28),
              SafeArea(child: _sectionHeader("Price Range")),
              const SizedBox(height: 12),
              Obx(() {
                return RangeSlider(
                  values: controller.priceRange.value,
                  min: 5,
                  max: 300,
                  activeColor: AppColor.orange,
                  inactiveColor: AppColor.orange.withOpacity(0.2),
                  divisions: 59,
                  labels: RangeLabels(
                    '\$${controller.priceRange.value.start.round()}',
                    '\$${controller.priceRange.value.end.round()}',
                  ),
                  onChanged: (values) {
                    controller.priceRange.value = values;
                  },
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$5', style: AppTextStyle.montserrat(fs: 13)),
                  Text('\$300', style: AppTextStyle.montserrat(fs: 13)),
                ],
              ),

              const SizedBox(height: 28),
              SafeArea(child: _sectionHeader("Delivery")),
              const SizedBox(height: 12),
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      controller.deliveryOptions.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _pill(
                          label: controller.deliveryOptions[index],
                          isSelected:
                              controller.selectedDeliveryIndex.value == index,
                          onTap:
                              () =>
                                  controller.selectedDeliveryIndex.value =
                                      index,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 30),
              SafeArea(
                child: CustomButton(
                  text: "Apply Filters",
                  color: AppColor.orange,
                  onPressed: () {
                    final sort =
                        controller.sortOptions[controller
                            .selectedSortIndex
                            .value];
                    final delivery =
                        controller.selectedDeliveryIndex.value == -1
                            ? "Not selected"
                            : controller.deliveryOptions[controller
                                .selectedDeliveryIndex
                                .value];
                    final range = controller.priceRange.value;

                    print("Sort By: $sort");
                    print("Delivery: $delivery");
                    print("Price Range: ${range.start} - ${range.end}");

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _sectionHeader(String title) {
  return Text(
    title,
    style: AppTextStyle.montserrat(
      fs: 18,
      fw: FontWeight.w600,
      c: AppColor.orange,
    ),
  );
}

Widget _pill({
  required String label,
  bool isSelected = false,
  VoidCallback? onTap,
  double fontSize = 12,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 6,
  ),
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: padding,
      decoration: BoxDecoration(
        color:
            isSelected
                ? AppColor.grey.withOpacity(0.4)
                : const Color.fromARGB(255, 245, 242, 242),
        borderRadius: BorderRadius.circular(20),
        border:
            isSelected
                ? Border.all(color: AppColor.orange, width: 1.5)
                : Border.all(color: Colors.transparent),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    ),
  );
}
