import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../custom_widgets/text_formfield.dart';
import '../controllers/profile_controller.dart';

// ignore: must_be_immutable
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
                  // Back button at the top left corner
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
                          // Profile photo
                          Container(
                            padding: EdgeInsets.all(4), // Border width
                            decoration: BoxDecoration(
                              color: AppColor.orange, // Border color
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                'https://photosking.net/wp-content/uploads/2024/06/korean-girl-photo_48.webp',
                              ),
                              backgroundColor: AppColor.grey,
                            ),
                          ),

                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed: () {
                              // Handle edit photo
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColor.orange, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19), // Optional: for rounded corners
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
                          Obx(
                            () => CustomTextField(
                              hint: "Enter full name",
                              controller: controller.nameController,
                              focusNode: controller.nameFocus,
                              readOnly: !controller.isEditing.value,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => CustomTextField(
                              hint: "Enter email",
                              controller: controller.emailController,
                              focusNode: controller.emailFocus,
                              readOnly: !controller.isEditing.value,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => CustomTextField(
                              hint: "Enter phone number",
                              controller: controller.phoneController,
                              focusNode: controller.phoneFocus,
                              readOnly: !controller.isEditing.value,
                            ),
                          ),
                          // const SizedBox(height: 20),
                          // Obx(
                          //   () => CustomTextField(
                          //     hint: "Enter password",
                          //     controller: controller.passwordController,
                          //     focusNode: controller.passwordFocus,
                          //     isPassword: true,
                          //     readOnly: !controller.isEditing.value,
                          //   ),
                          // ),
                          const SizedBox(height: 30),
                          Obx(
                            () => CustomButton(
                              text:
                                  controller.isEditing.value
                                      ? "Save Profile"
                                      : "Edit Profile",
                              onPressed: () {
                                if (controller.isEditing.value) {
                                  // Handle profile update
                                  controller.isEditing.value = false;
                                } else {
                                  controller.isEditing.value = true;
                                }
                              },
                              color: AppColor.orange,
                            ),
                          ),
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
