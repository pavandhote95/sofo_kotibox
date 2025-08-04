import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/notification_controller.dart';
// ignore: must_be_immutable
class NotificationView extends GetView<NotificationController> {
  @override
  NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          CurvedTopRightBackground(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Notification",
                          style: AppTextStyle.montserrat(
                            fs: 20,
                            fw: FontWeight.bold,
                            c: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    if (controller.notifications.isEmpty) {
                      return Center(
                        child: Text(
                          'No notifications yet',
                          style: AppTextStyle.manRope(
                            fs: 14,
                            c: AppColor.greyText,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: controller.notifications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final notification = controller.notifications[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.grey.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                              AppColor.orange.withOpacity(0.2),
                              child: Icon(Icons.notifications,
                                  color: AppColor.orange),
                            ),
                            title: Text(
                              notification['title']!,
                              style: AppTextStyle.montserrat(
                                fs: 14,
                                fw: FontWeight.w600,
                                c: AppColor.greyText,
                              ),
                            ),
                            subtitle: Text(
                              notification['subtitle']!,
                              style: AppTextStyle.manRope(
                                fs: 12,
                                c: AppColor.greyHint,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
