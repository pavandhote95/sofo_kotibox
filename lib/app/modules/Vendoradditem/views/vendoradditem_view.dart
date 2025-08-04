import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../custom_widgets/text_formfield.dart';
import '../controllers/vendoradditem_controller.dart';

class VendoradditemView extends StatelessWidget {
  final VendoradditemController controller = Get.put(VendoradditemController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),
          Column(
            children: [
              CustomAppBar(
                title: "Add Item",
                onActionTap: null,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Obx(() => Column(
                    children: [
                      GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            image: controller.selectedImage.value != null
                                ? DecorationImage(
                              image: FileImage(controller.selectedImage.value!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: controller.selectedImage.value == null
                              ? Text(
                            'Upload Image',
                            style: AppTextStyle.montserrat(fs: width * 0.04),
                          )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Item Name',
                        hint: 'Enter item name (e.g., T-Shirt)',
                        controller: controller.itemNameController,
                        focusNode: controller.itemNameFocus,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Item Description',
                        hint: 'Enter description (e.g., Cotton slim fit)',
                        controller: controller.itemDescController,
                        focusNode: controller.itemDescFocus,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Item Price',
                        hint: 'Enter price (e.g., 499)',
                        controller: controller.itemPriceController,
                        focusNode: controller.itemPriceFocus,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Item Quantity',
                        hint: 'Enter quantity',
                        controller: controller.itemQtyController,
                        focusNode: controller.itemQtyFocus,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Brand',
                        hint: 'Enter brand (e.g., Zara)',
                        controller: controller.brandController,
                        focusNode: controller.brandFocus,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Size',
                        hint: 'Enter size (e.g., M)',
                        controller: controller.sizeController,
                        focusNode: controller.sizeFocus,
                      ),
                      // const SizedBox(height: 16),
                      // controller.isLoading1.value
                      //     ? Center(child: CircularProgressIndicator())
                      //     : SizedBox(
                      //   height: 55,
                      //   width: double.infinity,
                      //   child: DropdownButtonFormField<String>(
                      //     decoration: InputDecoration(
                      //       labelStyle: AppTextStyle.montserrat(
                      //         c: Colors.black,
                      //         fs: 15,
                      //       ),
                      //       labelText: 'Select Shop',
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(25)),
                      //     ),
                      //     items: controller.shop.map((shop) {
                      //       return DropdownMenuItem<String>(
                      //         value: shop['id'].toString(),
                      //         child: Text(
                      //           shop['shop_name'],
                      //           style: AppTextStyle.montserrat(
                      //             c: Colors.black,
                      //             fs: 15,
                      //           ),
                      //         ),
                      //       );
                      //     }).toList(),
                      //     value: controller.selectedCategoryId.value?.toString(),
                      //     onChanged: (selectedId) {
                      //       controller.selectedCategoryId.value = int.tryParse(selectedId!);
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 30),
                      CustomButton(
                        isLoading: controller.isLoading.value,
                        text: 'Add Item',
                        onPressed: () {
                          if (controller.validateFields()) {
                            controller.addItem();
                          }
                        },
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}