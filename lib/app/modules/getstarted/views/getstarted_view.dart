import 'package:flutter/material.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/text_fonts.dart';

class GetstartedView extends StatelessWidget {
  const GetstartedView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          // Curved background circle
          Positioned(
            top: -height * 0.06,
            right: -width * 0.15,
            child: Container(
              height: height * 0.25,
              width: height * 0.25,
              decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(height * 0.25),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.25),

                Text(
                  'Welcome !',
                  style: AppTextStyle.montserrat(
                    fs: width * 0.09,
                    fw: FontWeight.w600,
                    c: Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.01),

                Text(
                  'Lorem ipsum dolor sit amet consectetur.\nScelerisque netus in dignissim hac.',
                  style: AppTextStyle.montserrat(
                    fs: width * 0.032,
                    c: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: height * 0.09),

                // Sign Up Button
                CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    // Sign up logic here
                  },
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w500,
                  borderRadius: 30,
                  height: height * 0.07,
                ),


                SizedBox(height: height * 0.018),

                // I Have an Account Button
                // I Have an Account Button
                SizedBox(
                  width: double.infinity,
                  height: height * 0.07,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {},
                    child: Text(
                      'I Have an Account',
                      style: AppTextStyle.montserrat(
                        c: Colors.black87,
                        fs: width * 0.04,
                        fw: FontWeight.w600, // ✅ Bold
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.015),
                Text(
                  'or',
                  style: AppTextStyle.montserrat(
                    fs: width * 0.033,
                    c: Colors.grey,
                    fw: FontWeight.w600, // ✅ Bold
                  ),
                ),

                SizedBox(height: height * 0.015),

                // Google Sign In
                _socialButton(
                  icon: 'assets/icons/google.png',
                  label: 'Sign in with Google',
                  onTap: () {},
                  width: width,
                  height: height,
                ),
                SizedBox(height: height * 0.015),

                // Facebook Sign In
                _socialButton(
                  icon: 'assets/icons/facebook.png',
                  label: 'Sign in with Facebook',
                  onTap: () {},
                  width: width,
                  height: height,
                ),
                SizedBox(height: height * 0.015),

                // Apple Sign In
                _socialButton(
                  icon: 'assets/icons/apple.png',
                  label: 'Sign in with Apple',
                  onTap: () {},
                  width: width,
                  height: height,
                ),
                SizedBox(height: height * 0.02),

                RichText(
                  text: TextSpan(
                    text: "Don't have an account ? ",
                    style: AppTextStyle.montserrat(
                      fs: width * 0.033,
                      c: Colors.black87,
                      fw: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'Create Account',
                        style: AppTextStyle.montserrat(
                          fs: width * 0.033,
                          c: AppColor.orange, // your theme orange
                          fw: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
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
            fw: FontWeight.w600, // ✅ Bold
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