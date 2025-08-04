import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsView> {
  bool notification = true;
  bool locationAddress = true;
  bool darkMode = true;

  @override
  void initState() {
    super.initState();
    // Set the status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.dark, // Use light if background is dark
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top bar
          Stack(
            children: [
              const SizedBox(height: 120),
              const CurvedTopRightBackground(),
              const CustomAppBar(title: 'Settings'),
            ],
          ),

          const SizedBox(height: 20),

          buildToggleTile('Notification', notification, (val) {
            setState(() => notification = val);
          }),
          buildToggleTile('Location Address', locationAddress, (val) {
            setState(() => locationAddress = val);
          }),
          buildToggleTile('Dark Mode', darkMode, (val) {
            setState(() => darkMode = val);
          }),

          const Divider(height: 30),

          ListTile(
            leading: const Icon(Icons.language, color: Colors.black),
            title: Text(
              'Language',
              style: AppTextStyle.montserrat(
                  fs: 16, fw: FontWeight.w600, c: Colors.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'English',
                  style: AppTextStyle.montserrat(
                      fs: 13, fw: FontWeight.w500, c: Colors.grey),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildToggleTile(
      String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyle.montserrat(
            fs: 16, fw: FontWeight.w600, c: Colors.black),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value ? 'ON' : 'OFF',
            style: AppTextStyle.montserrat(
                fs: 10, fw: FontWeight.w700, c: Colors.orange),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: Colors.orange,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
