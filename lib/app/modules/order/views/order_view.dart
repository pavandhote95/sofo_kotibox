import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import 'package:sofo/app/custom_widgets/loder.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/order/controllers/order_controller.dart';
import 'package:sofo/app/modules/order/views/order_details_view.dart';

class OrderView extends GetView<OrderController> {
  OrderView({super.key});
  @override
  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          /// Decorative top curve
          CurvedTopRightBackground(),

          /// Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 45),
              Center(
                child: Text(
                  'Order History',
                  style: AppTextStyle.montserrat(
                    fs: 20,
                    fw: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Scrollable Order List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return  Center(child: CustomLoadingIndicator());
                    }

                    if (controller.allOrders.isEmpty) {
                      return const Center(child: Text("No orders found"));
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.allOrders.length,
                      itemBuilder: (context, index) {
                        final order = controller.allOrders[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => OrderDetailsView(),
                                arguments: order); // ✅ pass order details
                          },
                          child: buildOrderCard(context, order),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title & Date
          Row(
            children: [
              Expanded(
                child: Text(
                  "Order Id# ${order['orderId']}",
                  style: AppTextStyle.montserrat(fs: 15, fw: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                order['date'],
                style: AppTextStyle.montserrat(fs: 13, c: AppColor.greyText),
              )
            ],
          ),
          const SizedBox(height: 12),

          /// Tracking Number
          Row(
            children: [
              Text(
                "Order Number : ",
                style: AppTextStyle.montserrat(fs: 12, c: AppColor.greyText),
              ),
              Expanded(
                child: Text(
                  order['tracking'],
                  style: AppTextStyle.montserrat(fs: 13, fw: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),

          /// Quantity & Amount
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Text(
                    "Quantity: ",
                    style:
                        AppTextStyle.montserrat(fs: 12, c: AppColor.greyText),
                  ),
                  Text(
                    "${order['quantity']}",
                    style:
                        AppTextStyle.montserrat(fs: 13, fw: FontWeight.w600),
                  )
                ],
              )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Total Amount: ",
                    style:
                        AppTextStyle.montserrat(fs: 12, c: AppColor.greyText),
                  ),
                  Text(
                    "\$${order['amount']}",
                    style:
                        AppTextStyle.montserrat(fs: 13, fw: FontWeight.w600),
                  )
                ],
              ))
            ],
          ),
          const SizedBox(height: 16),

          /// Details Button and Status
          Row(
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text("Details",
                              style: AppTextStyle.montserrat(
                                fs: 12,
                                c: Colors.white,
                                fw: FontWeight.w600,
                              ))))),

              /// Status
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(order['status'],
                          style: AppTextStyle.montserrat(
                            fs: 13,
                            fw: FontWeight.w600,
                            c: AppColor.orange,
                          ))))
            ],
          )
        ],
      ),
    );
  }
}
