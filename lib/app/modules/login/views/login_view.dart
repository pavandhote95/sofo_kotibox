import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/login/controllers/login_controller.dart';
import 'package:sofo/app/modules/register/views/register_view.dart';

import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_formfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // ✅ transparent status bar
        statusBarIconBrightness: Brightness.light, // ✅ white icons
      ),
      child: Scaffold(
        backgroundColor: AppColor.grey,
        body: Column(
          children: [
            // ✅ Background Image with Text on Top
            SizedBox(
              height: height * 0.25 + statusBarHeight, // ✅ extend image into status bar
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/login.jpg",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  // ✅ Shift text below status bar
                  Padding(
                    padding: EdgeInsets.only(top: statusBarHeight),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: AppTextStyle.montserrat(
                              fs: width * 0.075,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ✅ White Rounded Container Section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.03,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Email Field
                      CustomTextField(
                        label: 'Email',
                        hint: 'Input your registered email',
                        controller: controller.emailController,
                        focusNode: controller.emailFocusNode,
                      ),
                      const SizedBox(height: 16),

                      // ✅ Password Field
                      CustomTextField(
                        label: 'Password',
                        hint: 'Input your password',
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocusNode,
                        isPassword: true,
                      ),
                      const SizedBox(height: 10),

                      // ✅ Remember Me + Forgot Password
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
                              "Forgot Password?",
                              style: AppTextStyle.montserrat(
                                c: AppColor.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // ✅ Login Button
                      Obx(() {
                        return CustomButton(
                          isLoading: controller.isLoading.value,
                          text: "Login",
                          onPressed: () {
                            controller.postLoginApi();
                          },
                        );
                      }),
                      const SizedBox(height: 12),

                      // ✅ Social Login Buttons
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

                      // ✅ Register Redirect
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
                                  builder: (context) =>  RegisterView(),
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
    );
  }

  // ✅ Social Buttons Widget
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
