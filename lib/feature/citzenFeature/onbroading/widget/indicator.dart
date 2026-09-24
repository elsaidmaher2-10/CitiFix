import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.controller,
    required this.count,
    this.activeColor = ColorManger.kPrimary,
    this.dotColor = Colors.grey,
    this.dotSize = 12,
    this.spacing = 12.0,
    this.effectType = 'jumping',
  });

  final PageController controller;
  final int count;
  final Color activeColor;
  final Color dotColor;
  final double dotSize;
  final double spacing;
  final String effectType;

  @override
  Widget build(BuildContext context) {
    final Color schemeDot = Theme.of(context)
        .colorScheme
        .onSurfaceVariant
        .withValues(alpha: 0.45);
    final Color resolvedDot =
        dotColor == Colors.grey ? schemeDot : dotColor;
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      axisDirection: Axis.horizontal,
      effect: JumpingDotEffect(
        spacing: spacing.w,
        radius: dotSize.r,
        dotWidth: dotSize.w,
        dotHeight: dotSize.h,
        paintStyle: PaintingStyle.fill,
        strokeWidth: 1.5,
        dotColor: resolvedDot,
        activeDotColor: activeColor,
      ),
    );
  }
}
