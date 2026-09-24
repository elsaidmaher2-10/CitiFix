import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final int number;
  final Color? color;
  final Color iconcolor;

  const StatusCard({
    super.key,
    required this.number,
    required this.title,
    required this.iconPath,
    this.color,
    required this.iconcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.palette.outline.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(14.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: iconcolor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: SvgPicture.asset(
                  iconPath,
                  width: 16.w,
                  height: 16.w,
                  colorFilter: ColorFilter.mode(iconcolor, BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cairo(
                    color: context.palette.onSurfaceVariant,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              number.toString(),
              style: GoogleFonts.cairo(
                color: color ?? context.palette.onSurface,
                fontWeight: FontWeight.w900,
                fontSize: 26.sp,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
