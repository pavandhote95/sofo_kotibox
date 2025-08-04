import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionTap,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // transparent background
      elevation: 0, // remove shadow
      surfaceTintColor: Colors.transparent, // prevents any Material 3 tint
      scrolledUnderElevation: 0, // if using Material 3
      leading: showBackButton
          ? GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
      )
          : null,
      title: Text(
        title,
        style: AppTextStyle.montserrat(
          fs: 18,
          fw: FontWeight.bold,
          c: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: actionIcon != null
          ? [
        IconButton(
          icon: Icon(actionIcon, color: Colors.black),
          onPressed: onActionTap,
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
