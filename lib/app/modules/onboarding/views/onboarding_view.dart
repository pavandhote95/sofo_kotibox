import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sofo/app/modules/login/views/login_view.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../routes/app_pages.dart';
import '../../../custom_widgets/text_fonts.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Welcome!',
      'subtitle':
          'Lorem ipsum dolor sit amet consectetur.\nScelerisque netus in dignissim hac.',
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Discover Products',
      'subtitle':
          'Find the perfect sofa for every corner\nof your home in seconds.',
    },
    {
      'image': '', // custom Google Map UI
      'title': 'Fast Delivery',
      'subtitle':
          'Track your order live and enjoy hassle-free\nhome delivery with ease.',
    },
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });

          // ✅ Show dialog on 2nd onboarding
          if (index == 1) {
            Future.delayed(const Duration(milliseconds: 300), () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 10,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Cookie Settings",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "We use cookies to keep app working",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        "Accept all cookies",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColor.orange),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "Accept required cookies only",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.orange,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
          }
        },
        itemBuilder: (context, index) {
          return _buildPage(context, pages[index], size, index);
        },
      ),
    );
  }

  Widget _buildPage(
      BuildContext context, Map<String, String> data, Size size, int index) {
    final double verticalSpacing = size.height * 0.015;

    // ✅ Custom UI for 3rd onboarding screen
    if (index == 2) {
      return Stack(
        children: [
          SizedBox(
            height: size.height,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(22.7196, 75.8577),
                zoom: 14,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),
          // Search bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search Location",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          // Floating pin
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.location_pin,
              size: 50,
              color: AppColor.orange,
            ),
          ),
          // Bottom popup
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Where Exactly Are You?",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Please Let Us Know!",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              Position pos =
                                  await Geolocator.getCurrentPosition();
                              print(
                                  "📍 Current Location: ${pos.latitude}, ${pos.longitude}");
                              Get.to(const LoginView());
                            },
                            child: Text(
                              "Share Location",
                              style: AppTextStyle.montserrat(
                                c: Colors.white,
                                fs: 12,
                                fw: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SafeArea(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          Get.to(const LoginView());
                        },
                        child: Text(
                          "Enter Location Manually",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // ✅ Full-width image for 1 & 2
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.65,
            width: double.infinity,
            child: Image.asset(
              data['image']!,
              fit: BoxFit.cover, // ✅ No padding, full width
            ),
          ),
          SizedBox(height: verticalSpacing * 2),
          Text(
            data['title']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: size.width * 0.065,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: verticalSpacing),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Text(
              data['subtitle']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: size.width * 0.035,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          SizedBox(height: verticalSpacing * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (dotIndex) => _dot(dotIndex == currentPage),
            ),
          ),
          SizedBox(height: verticalSpacing),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.08,
                verticalSpacing,
                size.width * 0.08,
                13,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: _nextPage,
                  child: Text(
                    currentPage < pages.length - 1
                        ? 'Continue'
                        : 'Get Started',
                    style: AppTextStyle.montserrat(c: Colors.white, fs: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 20 : 8,
      decoration: BoxDecoration(
        color: active ? AppColor.orange : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
