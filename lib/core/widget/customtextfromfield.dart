import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfromfield extends StatelessWidget {
  const CustomTextfromfield({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.lable,
    this.readonly = false,
    this.initialValue,
    this.suffix,
    this.validator,
    this.obstext = false,
    this.prefix,
    this.onChanged,
    this.ktype = TextInputType.text,
    this.onTap,
    this.isworker = false,
    this.maxLines = 1,
    this.color,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
  });

  final Function()? onTap;
  final bool readonly;
  final String hinttext;
  final Widget? suffix;
  final TextInputType ktype;
  final bool obstext;
  final bool isworker;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final String lable;
  final String? initialValue;
  final int? maxLines;
  final Color? color;
  final Color? fillColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Dynamic fill color based on theme
    final backgroundColor =
        fillColor ??
        (isDark
            ? scheme.surfaceContainerHighest
            : (color ?? const Color(0xffF6F6F6)));

    // Border colors for different states
    final enabledBorderColor = isDark
        ? scheme.outline.withValues(alpha: 0.3)
        : Colors.grey.shade300;

    final focusedBorderColor = isworker ? scheme.primary : scheme.primary;

    final errorBorderColor = scheme.error;

    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      onTap: onTap,
      readOnly: readonly,
      keyboardType: ktype,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      obscureText: obstext,
      cursorColor: focusedBorderColor,
      style: GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? scheme.onSurface : const Color(0xFF0F172A),
      ),
      decoration: InputDecoration(
        prefixIcon: prefix != null
            ? IconTheme(
                data: IconThemeData(
                  color: isDark
                      ? scheme.onSurfaceVariant
                      : Colors.grey.shade600,
                  size: 20.sp,
                ),
                child: prefix!,
              )
            : null,
        suffixIcon: suffix != null
            ? IconTheme(
                data: IconThemeData(
                  color: isDark
                      ? scheme.onSurfaceVariant
                      : Colors.grey.shade600,
                  size: 20.sp,
                ),
                child: suffix!,
              )
            : null,
        labelStyle: GoogleFonts.cairo(
          color: isDark ? scheme.onSurfaceVariant : scheme.onSurface,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        alignLabelWithHint: true,
        labelText: lable,
        isDense: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        fillColor: backgroundColor,
        filled: true,
        hintText: hinttext,
        hintStyle: GoogleFonts.cairo(
          color: isDark
              ? scheme.onSurfaceVariant.withValues(alpha: 0.6)
              : scheme.onSurfaceVariant.withValues(alpha: 0.7),
          fontSize: 13.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          borderSide: BorderSide(
            color: enabledBorderColor,
            width: isDark ? 0.5 : 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          borderSide: BorderSide(
            color: errorBorderColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          borderSide: BorderSide(color: errorBorderColor, width: 2),
        ),
        errorStyle: GoogleFonts.cairo(fontSize: 11.sp, color: errorBorderColor),
      ),
    );
  }
}
