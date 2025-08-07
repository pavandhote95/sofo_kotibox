import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';
import 'package:sofo/app/custom_widgets/custom_button.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';
import 'package:sofo/app/modules/payment/views/payment_view.dart';

class ChooseDeliveryTimeView extends StatefulWidget {
  final String seledtedaddress;
  final String selectedpayment;
  final double totalPrice;
  final List<int> productIds;
  const ChooseDeliveryTimeView({
    super.key,
    required this.seledtedaddress,
    required this.selectedpayment,
    required this.totalPrice,
    required this.productIds,
  });

  @override
  State<ChooseDeliveryTimeView> createState() => _ChooseDeliveryTimeViewState();
}

class _ChooseDeliveryTimeViewState extends State<ChooseDeliveryTimeView> {
  String deliveryType = 'Regular';
  int selectedDateIndex = 0;
  int selectedTimeIndex = -1;
  DateTime currentMonth = DateTime.now();

  final List<String> times = [
    '9:00 AM',
    '10:00 AM',
    '12:00 PM',
    '3:00 PM',
    '5:00 PM',
    '8:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    print("Selected Address: ${widget.seledtedaddress}");
    print("Selected Payment: ${widget.selectedpayment}");
    print("Product IDs: ${widget.productIds}");
    print("Total Price: ${widget.totalPrice}");

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Center(
                        child: Text(
                          'Choose Delivery Time',
                          style: AppTextStyle.montserrat(
                            fs: 20,
                            fw: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  height: 0.1,
                  color: Color.fromARGB(102, 205, 205, 204),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _deliveryOption(
                          title: 'Regular Delivery',
                          isSelected: deliveryType == 'Regular',
                          onTap: () {
                            setState(() => deliveryType = 'Regular');
                            print("Delivery Type Selected: Regular");
                          },
                          details: [
                            'As soon as possible (within 2 hours)',
                            'Estimated arrival time (10:00 AM - 3:00 PM)',
                          ],
                        ),
                        const Divider(
                          height: 32,
                          color: Color.fromARGB(174, 215, 214, 214),
                        ),
                        _deliveryOption(
                          title: 'Scheduled Delivery',
                          isSelected: deliveryType == 'Scheduled',
                          onTap: () {
                            setState(() => deliveryType = 'Scheduled');
                            print("Delivery Type Selected: Scheduled");
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Select Date',
                          style: AppTextStyle.montserrat(
                            fs: 15,
                            fw: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _dateSelector(),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Color.fromARGB(174, 215, 214, 214),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Select Time',
                          style: AppTextStyle.montserrat(
                            fs: 15,
                            fw: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _timeSelector(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
          child: CustomButton(
            text: "Confirm Delivery Time",
            onPressed: () {
              String selectedDateStr = '';
              String selectedTime = '';

              if (deliveryType == "Scheduled") {
                final selectedDate = _generateDates(currentMonth)[selectedDateIndex];
                selectedTime = selectedTimeIndex != -1
                    ? times[selectedTimeIndex]
                    : 'Not selected';
                selectedDateStr =
                "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                print("Scheduled: $selectedDateStr at $selectedTime");
              } else {
                print("Delivery Type: Regular");
              }

              Get.to(() => PaymentView(
                deliveryType: deliveryType,
                selectedDate: selectedDateStr,
                selectedTime: selectedTime,
                selectedAddress: widget.seledtedaddress,
                selectedPayment: widget.selectedpayment,
                totalPrice: widget.totalPrice,
                productIds: widget.productIds,
              ));
            },
          ),
        ),
      ),
    );
  }

  Widget _deliveryOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    List<String>? details,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? AppColor.orange : Colors.grey.shade400,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTextStyle.montserrat(fs: 16, fw: FontWeight.w600),
              ),
            ],
          ),
          if (details != null)
            ...details.map(
                  (detail) => Padding(
                padding: const EdgeInsets.only(left: 36, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 8),
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        detail,
                        style: AppTextStyle.montserrat(
                          fs: 13.5,
                          c: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _dateSelector() {
    final datesList = _generateDates(currentMonth);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (!(currentMonth.month == DateTime.now().month &&
                      currentMonth.year == DateTime.now().year)) {
                    setState(() {
                      currentMonth = DateTime(
                        currentMonth.year,
                        currentMonth.month - 1,
                      );
                      selectedDateIndex = 0;
                      print("Month Changed: ${_monthName(currentMonth.month)} ${currentMonth.year}");
                    });
                  }
                },
                child: Icon(
                  Icons.chevron_left,
                  color: (currentMonth.month == DateTime.now().month &&
                      currentMonth.year == DateTime.now().year)
                      ? Colors.grey.shade400
                      : Colors.black,
                ),
              ),
              Text(
                "${_monthName(currentMonth.month)} ${currentMonth.year}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentMonth = DateTime(
                      currentMonth.year,
                      currentMonth.month + 1,
                    );
                    selectedDateIndex = 0;
                    print("Month Changed: ${_monthName(currentMonth.month)} ${currentMonth.year}");
                  });
                },
                child: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: datesList.length,
            itemBuilder: (context, index) {
              final date = datesList[index];
              final isSelected = selectedDateIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() => selectedDateIndex = index);
                  print(
                      "Date Selected: ${date.day}-${date.month}-${date.year}");
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: [
                      Text(
                        _dayName(date.weekday),
                        style: AppTextStyle.montserrat(fs: 12),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.orange : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          date.day.toString(),
                          style: AppTextStyle.montserrat(
                            fw: FontWeight.w600,
                            c: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<DateTime> _generateDates(DateTime baseDate) {
    final daysInMonth = DateUtils.getDaysInMonth(baseDate.year, baseDate.month);
    return List.generate(
      daysInMonth,
          (i) => DateTime(baseDate.year, baseDate.month, i + 1),
    ).where((d) => d.isAfter(DateTime.now().subtract(const Duration(days: 1)))).toList();
  }

  Widget _timeSelector() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: times.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        final isSelected = selectedTimeIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() => selectedTimeIndex = index);
            print("Time Selected: ${times[index]}");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.orange.withOpacity(0.15) : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? AppColor.orange : Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? AppColor.orange : Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(times[index], style: AppTextStyle.montserrat(fs: 13)),
              ],
            ),
          ),
        );
      },
    );
  }

  String _dayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[(weekday - 1) % 7];
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }
}