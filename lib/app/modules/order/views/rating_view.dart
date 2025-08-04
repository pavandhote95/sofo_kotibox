import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/views/order_cancel._view.dart';

class RateNowView extends StatefulWidget {
  const RateNowView({super.key});

  @override
  State<RateNowView> createState() => _RateNowViewState();
}

class _RateNowViewState extends State<RateNowView> {
  int rating = 3;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Orange curved top right corner
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Back arrow and Title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Get.back(),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Rate Now',
                            style:AppTextStyle.montserrat(
                              fs: 20,
                                fw: FontWeight.w600,
                        ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // To balance the back icon
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Card Container
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/rating.png', // Replace with your asset
                          height: 60,
                        ),
                        const SizedBox(height: 10),
                        Text('How is Your Shipper', style: AppTextStyle.montserrat(fs: 16, fw: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(
  'Your feedback will help us to improve shipping experience better.',
  style: AppTextStyle.montserrat(
    fs: 14,
    fw: FontWeight.w400,
    c: Colors.grey[600]!, // ✅ Add ! to fix the nullability issue
  ),
  textAlign: TextAlign.center,
),

                        const SizedBox(height: 15),

                        // Rating Stars
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  rating = index + 1;
                                });
                              },
                              icon: Icon(
                                Icons.star,
                                color: index < rating ? AppColor.orange : Colors.grey[300],
                                size: 28,
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 10),

                        // Comment Box
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: commentController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText: 'Add Comments',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

            Spacer(),

                  // Submit Button
                  SafeArea(
                    child: Padding(
                      padding:      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: CustomButton(
                        text: 'Submit',
                        onPressed: () {
                          Get.to(OrderCancelledView()); // Navigate to the same view to reset the form
                          // Submit logic here
                          debugPrint('Rating: $rating, Comment: ${commentController.text}');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
