import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_formfield.dart';
import '../../../custom_widgets/validations.dart';
import '../controllers/venderlogin_controller.dart';

class VendorRegisterView extends StatelessWidget {
  final VendorRegisterController controller = Get.put(VendorRegisterController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CurvedTopRightBackground(),
          Obx(() => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: "Vendor Registration", onActionTap: null),
                const SizedBox(height: 30),

                CustomTextField(
                  label: 'Shop Name',
                  hint: 'Input your shop name',
                  controller: controller.shopNameController,
                  focusNode: controller.shopNameFocus,
                ),
                const SizedBox(height: 16),

                /// Image Picker
                GestureDetector(
                  onTap: controller.pickShopImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey.shade100,
                    ),
                    child: controller.selectedImage.value == null
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 40, color: Colors.grey),
                        Text(
                          'Tap to upload shop image',
                          style: AppTextStyle.montserrat(
                              fs: width * 0.04, c: Colors.black54),
                        ),
                      ],
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        controller.selectedImage.value!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Shop Timing',
                  hint: 'e.g., 9 AM - 10 PM',
                  controller: controller.shopTimingController,
                  focusNode: controller.shopTimingFocus,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Shop Rating (1-5)',
                  hint: 'Enter a rating between 1 to 5',
                  controller: controller.shopRatingController,
                  focusNode: controller.shopRatingFocus,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'GST Number',
                  hint: 'Input your GST number',
                  controller: controller.gstController,
                  focusNode: controller.gstFocus,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'PAN Number',
                  hint: 'Input your PAN number',
                  controller: controller.panController,
                  focusNode: controller.panFocus,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'TAN Number',
                  hint: 'Input your TAN number',
                  controller: controller.tanController,
                  focusNode: controller.tanFocus,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Address',
                  hint: 'Input your shop address',
                  controller: controller.addressController,
                  focusNode: controller.addressFocus,
                ),
                const SizedBox(height: 16),

                /// Category Dropdown with loader
                controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(

                    decoration: InputDecoration(
                      labelStyle:  AppTextStyle.montserrat(
                      c:  Colors.black,
                      fs: 15,
                    ),
                      labelText: 'Select Shop Category',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    items: controller.categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category['id'].toString(),
                        child: Text(category['name'],style: AppTextStyle.montserrat(
                          c:  Colors.black,
                          fs: 15,
                        ),),
                      );
                    }).toList(),
                    value:
                    controller.selectedCategoryId.value?.toString(),
                    onChanged: (selectedId) {
                      controller.selectedCategoryId.value =
                          int.tryParse(selectedId!);
                    },
                  ),
                ),

                const SizedBox(height: 40),

                /// Register Button
                CustomButton(
                  isLoading: controller.isLoading.value,
                  text: 'Register as Vendor',
                  onPressed: () {
                    final shopName = controller.shopNameController.text.trim();
                    final shopTiming = controller.shopTimingController.text.trim();
                    final shopRating = controller.shopRatingController.text.trim();
                    final gst = controller.gstController.text.trim();
                    final pan = controller.panController.text.trim();
                    final tan = controller.tanController.text.trim();
                    final address = controller.addressController.text.trim();
                    final categoryId = controller.selectedCategoryId.value;
                 print(shopName);
                 print(shopTiming);
                 print(shopRating);
                 print(gst);
                 print(pan);
                 print(tan);
                 print(address);
                 print(categoryId);
                    // Validate required fields
                    if (shopName.isEmpty ||
                        shopTiming.isEmpty ||
                        shopRating.isEmpty ||
                        gst.isEmpty ||
                        pan.isEmpty ||
                        tan.isEmpty ||
                        address.isEmpty ||
                        categoryId == null ||
                        categoryId.toString().isEmpty) {


                      Get.snackbar(
                        'Incomplete Form',
                        'Please fill all required fields.',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Optional: Validate rating range
                    final rating = double.tryParse(shopRating);
                    if (rating == null || rating < 1 || rating > 5) {
                      Get.snackbar(
                        'Invalid Rating',
                        'Please enter a valid rating between 1 and 5.',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Call the registration method
                    controller.vendorRegister();
                  },

                ),

                const SizedBox(height: 15),

                /// Terms
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'By Registering you agree to our ',
                      style: AppTextStyle.montserrat(
                        c: Colors.black87,
                        fs: width * 0.032,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: AppTextStyle.montserrat(
                            c: AppColor.orange,
                            fs: width * 0.032,
                            fw: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
        ],
      ),
    );
  }

}