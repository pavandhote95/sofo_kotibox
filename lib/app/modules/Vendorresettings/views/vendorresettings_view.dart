import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendorresettings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),

          Column(
            children: [
              const CustomAppBar(title: 'Settings'),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildSettingItem(
                      icon: Icons.person,
                      title: 'Edit Profile',
                      onTap: () {},
                      width: width,
                    ),
                    _buildSettingItem(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: () {},
                      width: width,
                    ),
                    _buildSettingItem(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      onTap: () {},
                      width: width,
                    ),
                    _buildSettingItem(
                      icon: Icons.language,
                      title: 'Language',
                      onTap: () {},
                      width: width,
                    ),
                    _buildSettingItem(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: () {},
                      width: width,
                    ),
                    _buildSettingItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {
                        // You can add logout logic here
                      },
                      width: width,
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

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double width,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: AppTextStyle.montserrat(
            fs: width * 0.045,
            fw: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
