import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/CustomAppBar.dart';
import '../../../custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../controllers/vendor_categories_controller.dart';

class VendorCategoriesView extends StatelessWidget {
  final VendorCategoriesController controller = Get.put(VendorCategoriesController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CurvedTopRightBackground(),
          Column(
            children: [
              CustomAppBar(
                title: 'My Categories',
                onActionTap: null,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.selectedCategories.isEmpty) {
                    return  Center(
                      child: Text('No categories available.', style: AppTextStyle.montserrat(
                        fs: width * 0.045,
                        fw: FontWeight.w600,
                      ),),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: controller.selectedCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final category = controller.selectedCategories[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                category,
                                style: AppTextStyle.montserrat(
                                  fs: width * 0.045,
                                  fw: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              children: [

                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _deleteCategory(context, category,width);
                                  },
                                ),
                              ],
                            ),
                          ],
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

  void _deleteCategory(BuildContext context, String category, double width) {
    Get.defaultDialog(
      title: "Delete Category",
      titleStyle: AppTextStyle.montserrat(
        fs: width * 0.05,
        fw: FontWeight.w700,
        c: Colors.redAccent,
      ),
      middleText: "Are you sure you want to delete \"$category\"?",
      middleTextStyle: AppTextStyle.montserrat(
        fs: width * 0.042,
        fw: FontWeight.w500,
        c: Colors.black87,
      ),
      radius: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      backgroundColor: Colors.white,
      barrierDismissible: false,
      confirm: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onPressed: () {
          controller.selectedCategories.remove(category);
          Get.back();
        },
        icon: const Icon(Icons.delete_forever, color: Colors.white),
        label: Text(
          "Delete",
          style: AppTextStyle.montserrat(
            fs: width * 0.04,
            fw: FontWeight.w600,
            c: Colors.white,
          ),
        ),
      ),
      cancel: TextButton.icon(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.cancel, color: Colors.grey),
        label: Text(
          "Cancel",
          style: AppTextStyle.montserrat(
            fs: width * 0.04,
            fw: FontWeight.w500,
            c: Colors.grey,
          ),
        ),
      ),
    );
  }


}
