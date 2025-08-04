import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendor_customers_controller.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomersController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ✅ Curved background at the top
          const CurvedTopRightBackground(),

          // ✅ Main content with padding to avoid overlap
          Column(
            children: [
              // ✅ Custom stacked AppBar
              CustomAppBar(
                title: 'Customers',
              ),

              // ✅ Spacer to match AppBar height
              SizedBox(height: height * 0.02),

              // ✅ List of customers
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.customersList.length,
                    itemBuilder: (context, index) {
                      final customer = controller.customersList[index];
                      return Card(
                        elevation: 2,color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: const Icon(Icons.person, color: Colors.blue),
                          ),
                          title: Text(
                            customer['name'],
                            style: AppTextStyle.montserrat(
                              fs: width * 0.045,
                              fw: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            customer['email'],
                            style: AppTextStyle.montserrat(
                              fs: width * 0.04,
                              fw: FontWeight.w400,
                              c: Colors.grey,
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
        ],
      ),
    );
  }
}
