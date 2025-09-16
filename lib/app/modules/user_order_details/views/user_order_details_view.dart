import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/views/cancel_reason_order.dart';
import 'package:sofo/app/modules/order/views/track_order.dart';
import '../controllers/user_order_details_controller.dart';


class UserOrderDetailsView extends GetView<UserOrderDetailsController> {
 UserOrderDetailsView({super.key});
  final UserOrderDetailsController controller =
      Get.put(UserOrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),
          Column(
            children: [
              /// Header
              SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: () => Get.back(),
                    ),
                    const Spacer(),
                    Text(
                      'Order Details',
                      style: AppTextStyle.montserrat(
                        fs: 20,
                        fw: FontWeight.w600,
                        c: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              /// Body
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.orderDetails.isEmpty) {
                    return const Center(child: Text("No details found"));
                  }

                  final order = controller.orderDetails;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Order info
                        Text("Order #: ${order['order_number']}",
                            style: AppTextStyle.montserrat(
                                fs: 16, fw: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text("Status: ${order['status']}",
                            style: AppTextStyle.montserrat(
                                fs: 14,
                                fw: FontWeight.w500,
                                c: AppColor.orange)),
                        const Divider(height: 20),

                        /// Product Items
                        ListView.builder(
                          itemCount: order['items']?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = order['items'][index];
                            final storeItem = item['store_item'];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: Image.network(
                                  "http://kotiboxglobaltech.com/sofo_app/storage/app/public/${storeItem['image']}",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  storeItem['name'],
                                  style: AppTextStyle.montserrat(
                                      fs: 14, fw: FontWeight.w600),
                                ),
                                subtitle: Text(
                                    "Qty: ${item['quantity']}  |  Price: \$${item['price']}"),
                                trailing: Text(
                                  "\$${item['total_price']}",
                                  style: AppTextStyle.montserrat(
                                      fs: 14, fw: FontWeight.w600),
                                ),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 20),

                        /// Totals
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount",
                                style: AppTextStyle.montserrat(c: Colors.grey)),
                            Text("\$${order['total_amount']}",
                                style: AppTextStyle.montserrat(
                                    fw: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Grand Total",
                                style: AppTextStyle.montserrat(c: Colors.grey)),
                            Text("\$${order['grand_total']}",
                                style: AppTextStyle.montserrat(
                                    fw: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                }),
              ),

              /// Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  text: "Track Order",
                  onPressed: () => Get.to(() => MapDeliveryStatusView()),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  text: "Cancel Order",
                  onPressed: () => Get.to(() => CancelReasonView()),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
