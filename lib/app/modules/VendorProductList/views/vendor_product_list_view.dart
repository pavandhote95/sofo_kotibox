import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendor_product_list_controller.dart';

class VendorProductListView extends StatelessWidget {
  final VendorProductListController controller =  Get.put(VendorProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),
          Column(
            children: [
              CustomAppBar(title: 'My Products', onActionTap: null),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return Card(
                        elevation: 1,
                        color: AppColor.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    product['image'],
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                product['name'],
                                style: AppTextStyle.montserrat(
                                    fs: 18,
                                    fw: FontWeight.bold,
                                    c: Colors.black),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product['description'],
                                style: AppTextStyle.montserrat(fs: 14),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Prices: ₹${product['price']}',
                                    style: AppTextStyle.montserrat(
                                        fs: 16,
                                        fw: FontWeight.bold,
                                        c: Colors.green),
                                  ),
                                  Text(
                                    'Qty: ${product['quantity']}',
                                    style: AppTextStyle.montserrat(
                                        fs: 14, fw: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Category: ${product['category']}',
                                    style: AppTextStyle.montserrat(
                                        fs: 14,
                                        c: Colors.orange.shade700),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      controller.deleteProduct(index);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red, size: 20),
                                    label: Text(
                                      'Delete',
                                      style: AppTextStyle.montserrat(
                                          fs: 13,
                                          c: Colors.orange.shade700),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor:
                                      Colors.red.withOpacity(0.1),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                    ),
                                  ),
                                ],
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
