import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../custom_widgets/curved_top_container.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool orderUpdates = true;
  bool promoOffers = true;
  bool appNews = true;

  @override
  void initState() {
    super.initState();
    // Set transparent status bar with dark icons
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Top Bar
          Stack(
            children: [
              const SizedBox(height: 120),
              const CurvedTopRightBackground(),
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Notification',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Toggle Options
          buildToggleTile('Order Updates', orderUpdates, (val) {
            setState(() => orderUpdates = val);
          }),
          buildToggleTile('Promo Offers', promoOffers, (val) {
            setState(() => promoOffers = val);
          }),
          buildToggleTile('App News', appNews, (val) {
            setState(() => appNews = val);
          }),
        ],
      ),
    );
  }

  Widget buildToggleTile(String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value ? 'ON' : 'OFF',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
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
