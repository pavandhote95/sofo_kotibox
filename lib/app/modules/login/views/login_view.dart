import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_formfield.dart';
import '../../register/views/register_view.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  bool rememberMe = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final storage = GetStorage();

  // ✅ Remember Me toggle
  void toggleRememberMe(bool? value) {
    setState(() {
      rememberMe = value ?? false;
    });
  }

  // ✅ Login API
  Future<void> postLoginApi() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      Utils.showErrorToast("Email is required");
      return;
    } else if (password.isEmpty) {
      Utils.showErrorToast("Password is required");
      return;
    }

    String request = json.encode({"email": email, "password": password});

    try {
      setState(() => isLoading = true);

      RestApi restApi = RestApi();
      var response = await restApi.postApi(postLoginUrl, request);
      var responseJson = json.decode(response.body);

      if (response.statusCode == 201 && responseJson['status'] == true) {
        final token = responseJson['data']['token'];
        final userData = responseJson['data']['user'] ?? {};
        final int userId = userData['id'] ?? 0;
        final String name = userData['name'] ?? "";
        final String email = userData['email'] ?? "";

        // ✅ Save session
        storage.write('isLogin', true);
        storage.write('token', token);
        storage.write('userId', userId);
        storage.write('userName', name);
        storage.write('userEmail', email);

        // ✅ Handle Remember Me
        if (rememberMe) {
          storage.write('rememberEmail', emailController.text);
          storage.write('rememberPassword', passwordController.text);
        } else {
          storage.remove('rememberEmail');
          storage.remove('rememberPassword');
        }

        Utils.showToast(responseJson["message"] ?? "Login successful");

        // ✅ Navigate with GetX
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        String errorMessage = "Login failed! Try again.";

        if (response.statusCode == 401 ||
            (responseJson["message"]
                    ?.toString()
                    .toLowerCase()
                    .contains("invalid") ??
                false)) {
          errorMessage = "Email or password is incorrect.";
        } else if (responseJson["message"]
                ?.toString()
                .toLowerCase()
                .contains("token expire") ??
            false) {
          storage.erase();
          Get.offAllNamed(Routes.LOGIN);
          return;
        } else if (responseJson["errors"] != null) {
          String errorMessages = "";
          responseJson["errors"].forEach((key, value) {
            if (value is List) {
              errorMessages += "${value.join("\n")}\n";
            }
          });
          errorMessage = errorMessages.trim();
        } else if (responseJson["message"] != null) {
          errorMessage = responseJson["message"];
        }

        Utils.showErrorToast(errorMessage);
      }
    } catch (e) {
      debugPrint("Login API Error: $e");
      Utils.showErrorToast("Something went wrong. Please try again.");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();

    // ✅ Autofill Remember Me details if available
    final savedEmail = storage.read('rememberEmail') ?? "";
    final savedPassword = storage.read('rememberPassword') ?? "";
    if (savedEmail.isNotEmpty && savedPassword.isNotEmpty) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe = true;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColor.grey,
        body: Column(
          children: [
            // ✅ Top Banner
            SizedBox(
              height: height * 0.25 + statusBarHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/login.jpg",
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withOpacity(0.3)),
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

            // ✅ White Rounded Section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.03,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
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
                        controller: emailController,
                        focusNode: emailFocusNode,
                      ),
                      const SizedBox(height: 16),

                      // ✅ Password Field
                      CustomTextField(
                        label: 'Password',
                        hint: 'Input your password',
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        isPassword: true,
                      ),
                      const SizedBox(height: 10),

                      // ✅ Remember Me + Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                activeColor: AppColor.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: toggleRememberMe,
                              ),
                              Text(
                                "Remember Me",
                                style: AppTextStyle.montserrat(
                                  c: Colors.black87,
                                ),
                              ),
                            ],
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
                      CustomButton(
                        isLoading: isLoading,
                        text: "Login",
                        onPressed: postLoginApi,
                      ),
                      const SizedBox(height: 12),

                      // ✅ Social Buttons
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

  // ✅ Social Button Widget
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
