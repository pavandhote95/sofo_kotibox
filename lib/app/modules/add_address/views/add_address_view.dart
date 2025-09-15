import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import '../controllers/add_address_controller.dart';

class AddAddressView extends StatelessWidget {
  AddAddressView({super.key});

  final AddAddressController controller = Get.put(AddAddressController());

  @override

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

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
          /// Orange curved background
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

          /// Main UI content
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
                      'Add Address',
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTextField("Full Name", controller.nameController),
                        const SizedBox(height: 12),
                        _buildTextField("Phone Number", controller.phoneController),
                        const SizedBox(height: 12),
                        _buildTextField("Pincode", controller.pincodeController),
                        const SizedBox(height: 12),
                        _buildTextField("House No., Building Name", controller.houseController),
                        const SizedBox(height: 12),
                        _buildTextField("Road Name, Area, Colony", controller.areaController),
                        const SizedBox(height: 12),
                        _buildTextField("City", controller.cityController),
                        const SizedBox(height: 12),
                        _buildTextField("State", controller.stateController),

                        const SizedBox(height: 20),
                        Obx(() => Row(
                              children: [
                                _buildTypeButton("Home", controller),
                                const SizedBox(width: 12),
                                _buildTypeButton("Office", controller),
                              ],
                            )),

                        const SizedBox(height: 30),
                        CustomButton(
                          text: 'Save Address',
                          onPressed: () => controller.saveAddress(context),
                        ),
                        SizedBox(height: height * 0.02),
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

  /// Custom TextField Builder
  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyle.montserrat(fs: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.montserrat(
          fs: 14,
          c: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  /// Custom Type Selector Button
  Widget _buildTypeButton(String type, AddAddressController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: controller.selectedType.value == type
                ? AppColor.orange
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: controller.selectedType.value == type
                  ? AppColor.orange
                  : Colors.grey,
            ),
          ),
          child: Center(
            child: Text(
              type,
              style: AppTextStyle.montserrat(
                fs: 14,
                fw: FontWeight.w500,
                c: controller.selectedType.value == type
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
