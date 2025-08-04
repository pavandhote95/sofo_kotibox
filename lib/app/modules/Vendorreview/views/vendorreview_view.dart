import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendorreview_controller.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewsController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),

          Column(
            children: [
              CustomAppBar(title: 'Reviews'),
              SizedBox(height: height * 0.02),

              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.reviewsList.length,
                    itemBuilder: (context, index) {
                      final review = controller.reviewsList[index];
                      return Card(
                        elevation: 2,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange.shade100,
                            child: const Icon(Icons.star, color: Colors.orange),
                          ),
                          title: Text(
                            review['customerName'],
                            style: AppTextStyle.montserrat(
                              fs: width * 0.045,
                              fw: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['comment'],
                                style: AppTextStyle.montserrat(
                                  fs: width * 0.04,
                                  fw: FontWeight.w400,
                                  c: Colors.grey.shade800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(
                                  5,
                                      (i) => Icon(
                                    Icons.star,
                                    color: i < review['rating']
                                        ? Colors.orange
                                        : Colors.grey.shade300,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
