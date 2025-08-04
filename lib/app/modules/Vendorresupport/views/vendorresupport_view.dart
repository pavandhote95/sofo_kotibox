import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'Support'),
              SizedBox(height: height * 0.03),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'How can we help you?',
                  style: AppTextStyle.montserrat(
                    fs: width * 0.05,
                    fw: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(

                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _supportTile(

                      icon: Icons.chat_bubble_outline,
                      title: 'Live Chat',
                      subtitle: 'Talk to our support team in real-time',
                    ),
                    _supportTile(
                      icon: Icons.email_outlined,
                      title: 'Contact Us',
                      subtitle: 'Reach out via email for support',
                    ),
                    _supportTile(
                      icon: Icons.help_outline,
                      title: 'FAQs',
                      subtitle: 'Find answers to common questions',
                    ),
                    _supportTile(
                      icon: Icons.policy_outlined,
                      title: 'Privacy Policy',
                      subtitle: 'View our app policies and terms',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppColor.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(
          title,
          style: AppTextStyle.montserrat(
            fs: 16,
            fw: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyle.montserrat(
            fs: 14,
            fw: FontWeight.w400,
            c: Colors.grey,
          ),
        ),
        onTap: () {
          // Handle navigation or action
        },
      ),
    );
  }
}
