import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../custom_widgets/app_color.dart';
import '../../../../custom_widgets/custom_button.dart';
import '../../../../custom_widgets/text_fonts.dart';
import '../../../../custom_widgets/text_formfield.dart';
import '../../controllers/select_location_controller.dart';

class AddAddressDetailsView extends StatelessWidget {
  AddAddressDetailsView({super.key});

  final SelectLocationController controller = Get.put(
    SelectLocationController(),
  );

  // Controllers & focus nodes for fields
  final houseController = TextEditingController();
  final buildingController = TextEditingController();
  final landmarkController = TextEditingController();
  final otherController = TextEditingController();
  final receiverNameController = TextEditingController(text: 'Yash Saraswat');
  final receiverNumberController = TextEditingController(
    text: '+91 9509604064',
  );
  final houseFocus = FocusNode();
  final buildingFocus = FocusNode();
  final landmarkFocus = FocusNode();
  final otherFocus = FocusNode();
  final receiverNameFocus = FocusNode();
  final receiverNumberFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.orange,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios, size: 20,color: AppColor.white,),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Add Address Details",
          style: AppTextStyle.montserrat(
            fs: 16,
            fw: FontWeight.w600,
            c: AppColor.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              // 📍 Selected Address Card
              Container(
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: AppColor.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey)
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.currentLocality.value,
                            style: AppTextStyle.montserrat(
                              fs: 14,
                              fw: FontWeight.w600,
                              c: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.currentAddress.value,
                            style: AppTextStyle.montserrat(
                              fs: 13,
                              fw: FontWeight.w400,
                              c: Colors.grey[700]!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🏡 Address Fields using CustomTextField
              const SizedBox(height: 14),
              CustomTextField(
                label: "Building & Block No.",
                hint: "Enter building/block",
                controller: buildingController,
                focusNode: buildingFocus,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                label: "Landmark",
                hint: "Enter landmark",
                controller: landmarkController,
                focusNode: landmarkFocus,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                label: "Other Details",
                hint: "Enter details",
                controller: otherController,
                focusNode: otherFocus,
              ),

              const SizedBox(height: 24),

              // 👤 Receiver Info
              buildLabel("Receiver Name"),
              CustomTextField(
                // label: "Receiver Name",
                hint: "Receiver Name",
                controller: receiverNameController,
                focusNode: receiverNameFocus,
              ),
              const SizedBox(height: 14),

              buildLabel("Receiver Number"),
              CustomTextField(
                // label: "Receiver Number",
                hint: "Receiver Number",
                controller: receiverNumberController,
                focusNode: receiverNumberFocus,
              ),

              const SizedBox(height: 24),

              // ✅ Save Button
              CustomButton(
                text: "Save Address",
                height: 50,
                borderRadius: 12,
                onPressed: () {
                  // Save action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Text(
          label,
          style: AppTextStyle.montserrat(
            fs: 13,
            fw: FontWeight.w500,
            c: Colors.black,
          ),
        ),
      ),
    );
  }
}
