import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/views/call_view.dart';
import 'package:sofo/app/modules/order/views/chat_view.dart';
import 'package:sofo/app/modules/order/views/rating_view.dart';

import 'order_over_view.dart';

class MapDeliveryStatusView extends StatelessWidget {
  const MapDeliveryStatusView({super.key});

  @override
  Widget build(BuildContext context)  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Google Map View
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(26.9124, 75.7873),
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),

          // Orange curved top background
          Positioned(
            top: -height * 0.06,
            right: -width * 0.15,
            child: Container(
              height: height * 0.15,
              width: height * 0.23,
              decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(height * 0.2),
                ),
              ),
            ),
          ),

          // App bar with back button and title
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                       IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => Get.back(),
                      ),
                  const Spacer(),
                  Text(
                    "Track Delivery",
                    style: AppTextStyle.montserrat(
                      fs: 20,
                      fw: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),

          // Floating action buttons (optional)
          Positioned(
            top: height * 0.35,
            right: 40,
            child: CircleAvatar(
              backgroundColor: AppColor.orange,
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
          Positioned(
            top: height * 0.45,
            right: 40,
            child:  CircleAvatar(
              backgroundColor: AppColor.orange,
              radius: 8,
            ),
          ),

          // Bottom sheet for status and details
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping details",
                        style: AppTextStyle.montserrat(
                          fs: 16,
                          fw: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Rider & actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 20),
                          const SizedBox(width: 8),
                          Text("Saidul Islam",
                              style: AppTextStyle.montserrat(fs: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap:(){
                                Get.to(VoiceCallView());
                              },
                              child: Icon(Icons.call, color: Colors.black54, size: 20)),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: (){
                              Get.to(ChatView());
                            },
                            child: const Icon(Icons.chat_bubble_outline,
                                color: Colors.black54, size: 20),
                          ),
                        ],
                      )
                    ],
                  ),

                  const Divider(height: 20),

                  // ETA
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 20),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Estimated Arrival Time",
                              style: AppTextStyle.montserrat(
                                  fs: 12, c: Colors.black54)),
                          const SizedBox(height: 2),
                          Text("30 minutes",
                              style: AppTextStyle.montserrat(fs: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Address
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 20),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your address",
                              style: AppTextStyle.montserrat(
                                  fs: 12, c: Colors.black54)),
                          const SizedBox(height: 2),
                          Text("Kensington, SW10 2PL",
                              style: AppTextStyle.montserrat(fs: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Track Button
                  CustomButton(
                    text: "Delivery Status",
                    onPressed: () {
                     Get.to(OrderOverviewView());
                      // Track button logic
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
