import 'package:flutter/material.dart';
import 'package:sofo/app/custom_widgets/app_color.dart';


class CurvedTopRightBackground extends StatelessWidget {
final double heightMultiplier;
  final double widthMultiplier;
  final double radiusMultiplier;

  const CurvedTopRightBackground({
    super.key,
    this.heightMultiplier = 0.15,
    this.widthMultiplier = 0.23,
    this.radiusMultiplier = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: -screenHeight * 0.06,
      right: -screenWidth * 0.15,
      child: Container(
        height: screenHeight * heightMultiplier,
        width: screenHeight * widthMultiplier,
        decoration: BoxDecoration(
          color: AppColor.orange,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(screenHeight * radiusMultiplier),
          ),
        ),
      ),
    );
  }
}




//   final double height;
//   final double width;

//   const CurvedTopRightBackground({
//     super.key,
//     required this.height,
//     required this.width,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: -height * 0.06,
//       right: -width * 0.15,
//       child: Container(
//         height: height * 0.18,
//         width: height * 0.23,
//         decoration: BoxDecoration(
//           color: AppColor.orange,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(height * 0.50),
//           ),
//         ),
//       ),
//     );
//   }
// }
