import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../controllers/vendor_registration_success_controller.dart';

class VendorRegistrationSuccessView
    extends GetView<VendorRegistrationSuccessController>
     {
  const VendorRegistrationSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: AppColor.orange,
              size: width * 0.25,
            ),
            const SizedBox(height: 30),
            Text(
              "Thank You for Applying!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "We are reviewing your application.\nYou will be notified once it is approved.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: width * 0.04,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: "Go to Home",
              onPressed: () {
                Get.offAllNamed('/dashboard'); // ✅ adjust route if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}
