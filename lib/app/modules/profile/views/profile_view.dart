import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../custom_widgets/text_formfield.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -height * 0.06,
            right: -width * 0.15,
            child: Container(
              height: height * 0.18,
              width: height * 0.23,
              decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(height * 0.5),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Profile Image
                        // Profile Image
Obx(() => GestureDetector(
  onTap: () => controller.pickImage(),
  child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColor.orange,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[200],
          backgroundImage: controller.selectedImage.value != null
              ? FileImage(controller.selectedImage.value!)
              : (controller.profileModel.value.profileImageUrl != null &&
                      controller.profileModel.value.profileImageUrl!.isNotEmpty)
                  ? NetworkImage(controller.profileModel.value.profileImageUrl!)
                  : null, // <-- null so child will show
          child: (controller.selectedImage.value == null &&
                  (controller.profileModel.value.profileImageUrl == null ||
                      controller.profileModel.value.profileImageUrl!.isEmpty))
              ? Icon(
                  Icons.add_a_photo, // Placeholder Icon
                  size: 40,
                  color: AppColor.orange,
                )
              : null,
        ),
      ),
)),

                          const SizedBox(height: 10),

                          OutlinedButton(
                            onPressed: () => controller.pickImage(),
                            style: OutlinedButton.styleFrom(
                              side:
                                  BorderSide(color: AppColor.orange, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19),
                              ),
                            ),
                            child: Text(
                              'Edit Image',
                              style: AppTextStyle.montserrat(
                                fs: 14,
                                c: AppColor.orange,
                                fw: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Name
                          CustomTextField(
                            hint: "Enter full name",
                            controller: controller.nameController,
                            focusNode: controller.nameFocus,
                            readOnly: false, // Always editable
                          ),
                          const SizedBox(height: 20),

                          // Email
                          CustomTextField(
                            hint: "Enter email",
                            controller: controller.emailController,
                            focusNode: controller.emailFocus,
                            readOnly: false,
                          ),
                          const SizedBox(height: 20),

                          // Phone
                          CustomTextField(
                            hint: "Enter phone number",
                            controller: controller.phoneController,
                            focusNode: controller.phoneFocus,
                            readOnly: false,
                          ),
                          const SizedBox(height: 30),

                          // Save Button
                          Obx(() => CustomButton(
                                text: "Save Profile",
                                isLoading: controller.isLoading.value,
                                onPressed: () {
                                  controller.updateProfile();
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
