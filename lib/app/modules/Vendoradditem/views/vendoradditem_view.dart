
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
              CustomAppBar(title: "Add Item", onActionTap: null),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Obx(
                    () => Column(
                      
                      children: [
                        /// IMAGE PICKER
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
                                      image: FileImage(
                                          controller.selectedImage.value!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: controller.selectedImage.value == null
                                ? Text(
                                    'Upload Image',
                                    style:
                                        AppTextStyle.montserrat(fs: width * 0.04),
                                  )
                                : const SizedBox(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// ITEM NAME
                        CustomTextField(
                          label: 'Item Name',
                          hint: 'Enter item name (e.g., T-Shirt)',
                          controller: controller.itemNameController,
                          focusNode: controller.itemNameFocus,
                        ),
                        const SizedBox(height: 16),

                        /// ITEM DESCRIPTION
                        CustomTextField(
                          label: 'Item Description',
                          hint: 'Enter description (e.g., Cotton slim fit)',
                          controller: controller.itemDescController,
                          focusNode: controller.itemDescFocus,
                        ),
                        const SizedBox(height: 16),

                        /// ITEM PRICE
                        CustomTextField(
                          label: 'Item Price',
                          hint: 'Enter price (e.g., 499)',
                          controller: controller.itemPriceController,
                          focusNode: controller.itemPriceFocus,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),

                        /// ITEM QUANTITY
                        CustomTextField(
                          label: 'Item Quantity',
                          hint: 'Enter quantity',
                          controller: controller.itemQtyController,
                          focusNode: controller.itemQtyFocus,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),

                        /// BRAND
                        CustomTextField(
                          label: 'Brand',
                          hint: 'Enter brand (e.g., Zara)',
                          controller: controller.brandController,
                          focusNode: controller.brandFocus,
                        ),
                        const SizedBox(height: 16),

                        /// SIZE
                        CustomTextField(
                          label: 'Size',
                          hint: 'Enter size (e.g., M)',
                          controller: controller.sizeController,
                          focusNode: controller.sizeFocus,
                        ),
                        const SizedBox(height: 16),

                 /// SHOP DROPDOWN
Obx(() {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelStyle: AppTextStyle.montserrat(
        c: Colors.black,
        fs: 15,
      ),
      labelText: 'Select Your Shop',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.2),
        borderRadius: BorderRadius.circular(25),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 1.8),
        borderRadius: BorderRadius.circular(25),
      ),
    ),
    value: controller.selectedShopId.value?.toString(),
    items: controller.isLoadingShops.value
        ? [
            DropdownMenuItem<String>(
              value: null,
              enabled: false,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.orange, // ✅ Orange loader
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Loading shops...",
                    style: AppTextStyle.montserrat(
                      c: Colors.grey,
                      fs: 14,
                    ),
                  ),
                ],
              ),
            )
          ]
        : controller.shops.isEmpty
            ? [
                DropdownMenuItem<String>(
                  value: null,
                  enabled: false,
                  child: Text(
                    "No shops available",
                    style: AppTextStyle.montserrat(
                      c: Colors.red,
                      fs: 14,
                    ),
                  ),
                )
              ]
            : controller.shops.map((shop) {
                return DropdownMenuItem<String>(
                  value: shop['id'].toString(),
                  child: Text(
                    shop['shop_name'],
                    style: AppTextStyle.montserrat(
                      c: Colors.black,
                      fs: 15,
                    ),
                  ),
                );
              }).toList(),
    onChanged: (selectedId) {
      if (selectedId != null) {
        controller.selectedShopId.value = int.tryParse(selectedId);
      }
    },
  );
}),

                        const SizedBox(height: 30),

                        /// ADD ITEM BUTTON
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
                    ),
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
