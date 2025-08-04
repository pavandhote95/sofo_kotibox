import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'app_color.dart';


class CustomLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const CustomLoadingIndicator({
    Key? key,
    this.size = 40,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: color ?? AppColor.orange,
        size: size,
      ),
    );
  }
}
