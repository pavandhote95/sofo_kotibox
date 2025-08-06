import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';

class EditAddressView extends StatefulWidget {
  final String initialLabel;
  final Function(String updatedLabel)? onSave;

  const EditAddressView({
    super.key,
    required this.initialLabel,
    this.onSave,
  });

  @override
  State<EditAddressView> createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  final TextEditingController labelController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.initialLabel;
    phoneController.text = "(+88) 5446456789";
    addressController.text = "Michigan, New York City";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          // Orange curved background
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
          Column(
            children: [
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: () => Get.back(),
                    ),
                    const Spacer(),
                    Text(
                      'Edit Address',
                      style: AppTextStyle.montserrat(
                        fs: 20,
                        fw: FontWeight.w600,
                        c: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 24),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTextField("Label", labelController),
                        const SizedBox(height: 12),
                        _buildTextField("Phone Number", phoneController),
                        const SizedBox(height: 12),
                        _buildTextField("Address", addressController, maxLines: 3),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Save',
                          onPressed: () {
                            if (widget.onSave != null) {
                              widget.onSave!(labelController.text.trim());
                            }
                            Get.back();
                          },
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyle.montserrat(fs: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.montserrat(
          fs: 14,
          c: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
