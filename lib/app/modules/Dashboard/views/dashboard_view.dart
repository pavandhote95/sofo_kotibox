import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: controller.pages[controller.selectedIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: controller.changeIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.white,
              selectedItemColor: AppColor.orange,
              unselectedItemColor: AppColor.greyBarIcon,
              selectedLabelStyle: AppTextStyle.manRope(
                fs: 14,
                fw: FontWeight.w600,
                c: AppColor.orange,
              ),
              unselectedLabelStyle: AppTextStyle.manRope(
                fs: 14,
                c: AppColor.greyBarIcon,
                fw: FontWeight.w600,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/icons/home_bar.png', controller.selectedIndex == 0),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/icons/order_bar.png', controller.selectedIndex == 1),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/icons/cart.png', controller.selectedIndex == 2),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/icons/account_bar.png', controller.selectedIndex == 3),
                  label: 'Account',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(String path, bool isActive) {
    return Image.asset(
      path,
      height: 28,
      width: 28,
      color: isActive ? AppColor.orange : AppColor.greyBarIcon,
    );
  }
}
