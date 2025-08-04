import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_formfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterController controller = Get.put(RegisterController());

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CurvedTopRightBackground(),

          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const BackButton(color: Colors.black),
                SizedBox(height: height * 0.015),

                Center(
                  child: Text(
                    'Welcome',
                    style: AppTextStyle.montserrat(
                      fs: width * 0.09,
                      fw: FontWeight.bold,
                      c: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.035),

                CustomTextField(
                  label: 'Name',
                  hint: 'Input your name',
                  controller: controller.nameController,
                  focusNode: controller.nameFocus,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Email',
                  hint: 'Input your email',
                  controller: controller.emailController,
                  focusNode: controller.emailFocus,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Mobile',
                  hint: 'Input your mobile number',
                  controller: controller.mobileController,
                  focusNode: controller.mobileFocus,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Password',
                  hint: 'Input your password',
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocus,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Confirm your password',
                  controller: controller.confirmPasswordController,
                  focusNode: controller.confirmPasswordFocus,
                  isPassword: true,
                ),
                const SizedBox(height: 8),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'At least 8 characters with a combination of letters and numbers',
                        style: AppTextStyle.montserrat(
                          fs: width * 0.032,
                          c: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.10),

                Obx(
                      () => CustomButton(
                    isLoading: controller.isLoading.value,
                    text: 'Register',
                    onPressed: () {
                      final name = controller.nameController.value.text.trim();
                      final email = controller.emailController.value.text.trim();
                      final mobile = controller.mobileController.value.text.trim();
                      final pass = controller.passwordController.text.trim();
                      final confirmPass = controller.confirmPasswordController.text.trim();

                      // Field validations
                      if (name.isEmpty) {
                        Utils.showErrorToast("Name is required");
                        return;
                      } else if (email.isEmpty) {
                        Utils.showErrorToast("Email is required");
                        return;
                      } else if (mobile.isEmpty) {
                        Utils.showErrorToast("Mobile number is required");
                        return;
                      } else if (pass.isEmpty) {
                        Utils.showErrorToast("Password is required");
                        return;
                      } else if (confirmPass.isEmpty) {
                        Utils.showErrorToast("Confirm Password is required");
                        return;
                      } else if (pass != confirmPass) {
                        Utils.showErrorSnackbar("Error", "Passwords do not match");
                        return;
                      }

                      // If all validations pass, call API
                      controller.postRegisterApi();
                    },
                  ),
                ),

                const SizedBox(height: 12),

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
          ),
        ],
      ),
    );
  }
}
