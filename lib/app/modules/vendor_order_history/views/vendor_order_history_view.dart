import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/modules/user_order_details/views/user_order_details_view.dart';
import '../controllers/vendor_order_history_controller.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';


class VendorOrderHistoryView extends GetView<VendorOrderHistoryController> {
  VendorOrderHistoryView({super.key});

  final VendorOrderHistoryController controller =
      Get.put(VendorOrderHistoryController());

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
                  'Order Overview',
                  style: AppTextStyle.montserrat(
                    fs: 20,
                    fw: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildTabButton("Delivered"),
                      buildTabButton("Processing"),
                      buildTabButton("Cancelled"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Orders
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.filteredOrders.isEmpty) {
                      return const Center(child: Text("No orders found"));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = controller.filteredOrders[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => UserOrderDetailsView(),
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

  Widget buildTabButton(String title) {
    return Obx(() {
      final isSelected = controller.selectedTab.value == title;
      return GestureDetector(
        onTap: () => controller.selectedTab.value = title,
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            style: AppTextStyle.montserrat(
              fs: 13,
              fw: FontWeight.w500,
              c: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    });
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
                  "Order ${order['order_id'] ?? order['id'] ?? ''}",
                  style: AppTextStyle.montserrat(fs: 15, fw: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                order['created_at'] ?? '',
                style: AppTextStyle.montserrat(fs: 13, c: AppColor.greyText),
              )
            ],
          ),
          const SizedBox(height: 12),

          /// Tracking Number
          Row(
            children: [
              Text(
                "Tracking Number: ",
                style: AppTextStyle.montserrat(fs: 12, c: AppColor.greyText),
              ),
              Expanded(
                child: Text(
                  order['order_number'] ?? 'N/A',
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
                      style: AppTextStyle.montserrat(fs: 12, c: AppColor.greyText),
                    ),
                    Text(
                      "${order['quantity'] ?? 0}",
                      style: AppTextStyle.montserrat(fs: 13, fw: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Total Amount: ",
                      style: AppTextStyle.montserrat(fs: 12, c: AppColor.greyText),
                    ),
                    Text(
                      "\$${order['total_amount'] ?? 0}",
                      style: AppTextStyle.montserrat(fs: 13, fw: FontWeight.w600),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),

          /// Details Button and Status
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColor.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Details",
                      style: AppTextStyle.montserrat(
                        fs: 12,
                        c: Colors.white,
                        fw: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    order['status'] ?? '',
                    style: AppTextStyle.montserrat(
                      fs: 13,
                      fw: FontWeight.w600,
                      c: AppColor.orange,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
