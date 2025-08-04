import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/views/call_view.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-right orange curve
              /// Orange decorative shape
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

          SafeArea(
            child: Column(
              children: [
                // Top bar
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12),
  child: SizedBox(
    height: 50, // Set a fixed height for alignment
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
            "Mike Davis",
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

                const SizedBox(height: 10),

                // Chat bubble section
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Today",
                            style: AppTextStyle.montserrat(
                              fs: 12,
                              fw: FontWeight.w500,
                              c: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),

                      // User message
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 10),
                          constraints: const BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: AppColor.orange,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Hi, I placed an order this morning for furniture pickup. Can you confirm if it has been picked up yet?",
                            style: AppTextStyle.montserrat(
                              fs: 14,
                              c: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "11.00 AM",
                          style: AppTextStyle.montserrat(
                            fs: 12,
                            c: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Support message
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 10),
                          constraints: const BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Hello! Thank you for reaching out. Let me check the status of your order. Could you please provide me with your order number?",
                            style: AppTextStyle.montserrat(
                              fs: 14,
                              c: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "11.05 AM",
                          style: AppTextStyle.montserrat(
                            fs: 12,
                            c: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // User reply
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 10),
                          constraints: const BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: AppColor.orange,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Sure, my order number is #12345.",
                            style: AppTextStyle.montserrat(
                              fs: 14,
                              c: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "11.06 AM",
                          style: AppTextStyle.montserrat(
                            fs: 12,
                            c: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Message input
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Type a message",
                                      border: InputBorder.none,
                                      hintStyle: AppTextStyle.montserrat(
                                        fs: 14,
                                        c: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(Icons.image, color: Colors.grey.shade500, size: 20),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Get.to(VoiceCallView());
                            // Handle send message action
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: AppColor.orange,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.send, color: Colors.white, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
