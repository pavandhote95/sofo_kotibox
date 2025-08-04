import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/login/controllers/login_controller.dart';
import 'package:sofo/app/modules/register/views/register_view.dart';

import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_formfield.dart';
import '../../../routes/app_pages.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
return AnnotatedRegion<SystemUiOverlayStyle>(
  value: SystemUiOverlayStyle(
    statusBarColor: AppColor.grey,
    statusBarIconBrightness: Brightness.dark,
  ),
  child: Scaffold(
        backgroundColor: AppColor.grey,
        body: SafeArea(
          child: Container(
            color: AppColor.grey,
            child: Column(
              children: [
                SizedBox(height: height * 0.10),
                Text(
                  'Welcome Back!',
                  style: AppTextStyle.montserrat(
                    fs: width * 0.07,
                    fw: FontWeight.bold,
                    c: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please login first to start your Delivered Fast',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.montserrat(
                    fs: width * 0.035,
                    c: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.04),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.backgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.03),
                          CustomTextField(
                            label: 'Email',
                            hint: 'Input your registered email',
                            controller: controller.emailController,
                            focusNode: controller.emailFocusNode,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Input your password',
                            hint: 'Input your password',
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocusNode,
                            isPassword: true,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Row(
                                  children: [
                                    Checkbox(
                                      value: controller.rememberMe.value,
                                      activeColor: AppColor.orange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: controller.toggleRememberMe,
                                    ),
                                    Text(
                                      "Remember Me",
                                      style: AppTextStyle.montserrat(
                                        c: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password",
                                  style: AppTextStyle.montserrat(
                                    c: AppColor.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return CustomButton(
                              isLoading: controller.isLoading.value,
                              text: "Login",
                              onPressed: () {
                                controller.postLoginApi();
                              },
                            );
                          }
                          ),
                          const SizedBox(height: 12),
                          _socialButton(
                            icon: 'assets/icons/google.png',
                            label: 'Sign in with Google',
                            onTap: () {},
                            width: width,
                            height: height,
                          ),
                          SizedBox(height: height * 0.015),
                          _socialButton(
                            icon: 'assets/icons/facebook.png',
                            label: 'Sign in with Facebook',
                            onTap: () {},
                            width: width,
                            height: height,
                          ),
                          SizedBox(height: height * 0.015),
                          _socialButton(
                            icon: 'assets/icons/apple.png',
                            label: 'Sign in with Apple',
                            onTap: () {},
                            width: width,
                            height: height,
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account? ",
                                style: AppTextStyle.montserrat(
                                  c: Colors.black87,
                                  fs: width * 0.035,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterView(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Create Account",
                                  style: AppTextStyle.montserrat(
                                    c: AppColor.orange,
                                    fw: FontWeight.bold,
                                    fs: width * 0.035,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
    required double width,
    required double height,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height * 0.07,
      child: OutlinedButton.icon(
        icon: Image.asset(icon, height: height * 0.03),
        label: Text(
          label,
          style: AppTextStyle.montserrat(
            fs: width * 0.033,
            c: Colors.black87,
            fw: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        onPressed: onTap,
      ),
    );
  }
}
