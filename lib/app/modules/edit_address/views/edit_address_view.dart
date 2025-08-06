import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import '../controllers/edit_address_controller.dart';

class EditAddressView extends StatefulWidget {
  final Map<String, String> initialData;

  const EditAddressView({super.key, required this.initialData});

  @override
  State<EditAddressView> createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  final EditAddressController controller = Get.put(EditAddressController());

  late String selectedType;
  final TextEditingController fullName = TextEditingController();
  final TextEditingController houseNo = TextEditingController();
  final TextEditingController roadName = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController stateText = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialData['type'] ?? 'Home';
    fullName.text = widget.initialData['full_name'] ?? '';
    houseNo.text = widget.initialData['house_no'] ?? '';
    roadName.text = widget.initialData['road_name'] ?? '';
    city.text = widget.initialData['city'] ?? '';
    stateText.text = widget.initialData['state'] ?? '';
    pincode.text = widget.initialData['pincode'] ?? '';
    phone.text = widget.initialData['phone'] ?? '';
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
          /// Orange curved background
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

          /// Main UI
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
                    child: Obx(() => Column(
                          children: [
                            _buildTextField("Full Name", fullName),
                            const SizedBox(height: 12),
                            _buildTextField("Phone Number", phone),
                            const SizedBox(height: 12),
                            _buildTextField("Pincode", pincode),
                            const SizedBox(height: 12),
                            _buildTextField("House No., Building Name", houseNo),
                            const SizedBox(height: 12),
                            _buildTextField("Road Name, Area, Colony", roadName),
                            const SizedBox(height: 12),
                            _buildTextField("City", city),
                            const SizedBox(height: 12),
                            _buildTextField("State", stateText),

                            const SizedBox(height: 20),
                            Row(
                              children: [
                                _buildTypeButton("Home"),
                                const SizedBox(width: 12),
                                _buildTypeButton("Office"),
                              ],
                            ),

                            const SizedBox(height: 30),
                            controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    text: 'Update Address',
                                    onPressed: () {
                                    controller.updateAddress({
  'id': widget.initialData['id']!,
  'type': selectedType,
  'full_name': fullName.text.trim(),
  'house_no': houseNo.text.trim(),
  'road_name': roadName.text.trim(),
  'city': city.text.trim(),
  'state': stateText.text.trim(),
  'pincode': pincode.text.trim(),
  'phone': phone.text.trim(),
}, context);

                                    },
                                  ),
                            SizedBox(height: height * 0.02),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Reusable Text Field
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

  /// Address Type Button (Home/Office)
  Widget _buildTypeButton(String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selectedType == type ? AppColor.orange : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selectedType == type ? AppColor.orange : Colors.grey,
            ),
          ),
          child: Center(
            child: Text(
              type,
              style: AppTextStyle.montserrat(
                fs: 14,
                fw: FontWeight.w500,
                c: selectedType == type ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
