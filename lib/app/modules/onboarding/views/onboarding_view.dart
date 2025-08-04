import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';

import '../../../custom_widgets/app_color.dart';
import '../../../routes/app_pages.dart';

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
      'title': 'Welcome !',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur.\nScelerisque netus in dignissim hac.',
    },
    {
      'title': 'Discover Products',
      'subtitle': 'Find the perfect sofa for every corner\nof your home in seconds.',
    },
    {
      'title': 'Fast Delivery',
      'subtitle': 'Track your order live and enjoy hassle-free\nhome delivery with ease.',
    },
  ];

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

  CustomClipper<Path> _getClipper(int index) {
    switch (index) {
      case 0:
        return FirstCurveClipper();
      case 1:
        return SecondCurveClipper();
      case 2:
        return ThirdCurveClipper();
      default:
        return FirstCurveClipper();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: _getClipper(currentPage),
              child: Container(
                height: size.height * 0.85,
                color: AppColor.orange
              ),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(context, pages[index], size);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, Map<String, String> data, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: size.height * 0.38),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            data['title']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            data['subtitle']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages.length,
                (index) => _dot(index == currentPage),
          ),
        ),
        const SizedBox(height: 30),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  currentPage < pages.length - 1 ? 'Continue' : 'Get Started',
                  style: AppTextStyle.montserrat(
                  c: Colors.white
                      ,
                    fs: 14
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 20 : 8,
      decoration: BoxDecoration(
        color: active ?  AppColor.orange : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

// Page 1 Curve
class FirstCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.75,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Page 2 Curve
class SecondCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.4);
    path.cubicTo(
      size.width * 0.25,
      size.height * 0.6,
      size.width * 0.75,
      size.height * 0.2,
      size.width,
      size.height * 0.5,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Page 3 Curve
class ThirdCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.20);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.5,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
