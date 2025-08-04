import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/views/cancel_reason_order.dart';

class VoiceCallView extends StatelessWidget {
  const VoiceCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
         onTap: (){
               Get.to(() => const CancelReasonView());
          },
          
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
      
              // Back + Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Voice Call",
                          style: AppTextStyle.montserrat(
                            fs: 20,
                            fw: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              const SizedBox(height: 60),
      
              // Profile Circle
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade100,
                ),
              ),
      
              const SizedBox(height: 30),
      
              // Name
              Text(
                'Nabeel Ahmad',
                style: AppTextStyle.montserrat(
                  fs: 18,
                  fw: FontWeight.w600,
                ),
              ),
      
              const SizedBox(height: 8),
      
              // Status
              Text(
                'Connected',
                style: AppTextStyle.montserrat(
                  fs: 14,
                  fw: FontWeight.w500,
                  c: AppColor.orange,
                ),
              ),
      
              const Spacer(),
      
              // Call Controls
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Speaker
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      radius: 28,
                      child: const Icon(Icons.volume_up, color: Colors.white),
                    ),
      
                    // End Call
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 28,
                      child: const Icon(Icons.call_end, color: Colors.white),
                    ),
      
                    // Mic
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      radius: 28,
                      child: const Icon(Icons.mic, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
