import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import 'package:sofo/app/modules/VendorDashboard/views/vendor_dashboard_view.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../notification/note_permission.dart';
import '../../notification/views/setting_view.dart';
import '../../profile/views/profile_view.dart';
import '../../venderlogin/views/venderRegister_view.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  final AccountController controller = Get.put(AccountController());

  AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          CurvedTopRightBackground(),
          RefreshIndicator(
            onRefresh: () async {
              await controller.fetchUserProfile();
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(), // Important for short content

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Account Setting',
                          style: AppTextStyle.montserrat(
                            fs: 20,
                            fw: FontWeight.w600,
                            c: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    /// Profile Info
                    /// Profile
                    Obx(() => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColor.orange, width: 3),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  controller.profileImageUrl.value.isNotEmpty
                                      ? controller.profileImageUrl.value
                                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSra33TXWFQcgtUWNap2aDvm97GZflRLYtxiA&s',
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.name.value.isNotEmpty
                                        ? controller.name.value
                                        : 'Loading...',
                                    style: AppTextStyle.montserrat(
                                      fs: 20,
                                      fw: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    controller.email.value.isNotEmpty
                                        ? '@${controller.email.value.split('@').first}'
                                        : '',
                                    style: AppTextStyle.montserrat(
                                      fs: 15,
                                      c: AppColor.greyHint,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),

                    const SizedBox(height: 30),

                    /// Menu Items
                    _buildSettingItem(
                      icon: CupertinoIcons.person,
                      text: "Edit Profile",
                      onTap: () => Get.to(() => ProfileView()),
                    ),
                    const SizedBox(height: 15),
                    _buildSettingItem(
                      icon: CupertinoIcons.gear,
                      text: "Settings",
                      onTap: () => Get.to(() => SettingsView()),
                    ),
                    const SizedBox(height: 15),
                    _buildSettingItem(
                      icon: CupertinoIcons.bell,
                      text: "Notification Preferences",
                      onTap: () => Get.to(() => NotificationScreen()),
                    ),
                    const SizedBox(height: 15),

                    /// Vendor Buttons
                    Obx(() {
                      final vendorValue = controller.becomeVendor.value;

                      if (vendorValue == '0' || vendorValue == "1") {
                        // Show Become a Vendor
                        return Column(
                          children: [
                            _buildSettingItem(
                              icon: CupertinoIcons.briefcase,
                              text: "Become a Vendor",
                              onTap: () => Get.to(() => VendorRegisterView()),
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      } else if (vendorValue == '2') {
                        // Show Vendor Dashboard
                        return Column(
                          children: [
                            _buildSettingItem(
                              icon: CupertinoIcons.rectangle_stack_person_crop,
                              text: "Vendor Dashboard",
                              onTap: () => Get.to(() => VendorDashboardView(controller.userid)),
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      } else {
                        // Optional fallback (if unexpected value)
                        return const SizedBox.shrink();
                      }
                    }),
                    const SizedBox(height: 50),

                    /// Logout
                   SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.postLogOut(), // ✅ Corrected here
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColor.orange),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.orange),
                            ),
                          )
                              : Text(
                            "Log Out",
                            style: AppTextStyle.montserrat(
                              fs: 16,
                              fw: FontWeight.w600,
                              c: AppColor.orange,
                            ),
                          ),
                        ),
                      ),


                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.greyFieldBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColor.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.montserrat(fs: 15),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
