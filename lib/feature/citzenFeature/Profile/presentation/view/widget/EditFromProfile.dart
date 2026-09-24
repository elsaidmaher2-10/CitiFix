import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Editfromprofile extends StatelessWidget {
  const Editfromprofile({
    required this.role,
    super.key,
    required this.EmailCotroller,
    required this.nameCotroller,
    required this.addressCotroller,
    required this.phoneCotroller,
  });

  final TextEditingController phoneCotroller;
  final TextEditingController EmailCotroller;
  final TextEditingController nameCotroller;
  final TextEditingController addressCotroller;
  final bool role;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primaryThemeColor = role
        ? context.palette.workerprimary
        : context.palette.kPrimary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFieldSection(
            context,
            label: S.of(context).fullName,
            hint: S.of(context).fullName,
            controller: nameCotroller,
            icon: Icons.person_outline,
            themeColor: primaryThemeColor,
            isDark: isDark,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).email,
            hint: S.of(context).hintEmail,
            controller: EmailCotroller,
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            themeColor: primaryThemeColor,
            isDark: isDark,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).phone,
            hint: S.of(context).hintPhone,
            controller: phoneCotroller,
            icon: Icons.call_outlined,
            keyboardType: TextInputType.phone,
            themeColor: primaryThemeColor,
            isDark: isDark,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).address,
            hint: S.of(context).hintAddress,
            controller: addressCotroller,
            icon: Icons.location_on_outlined,
            themeColor: primaryThemeColor,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required Color themeColor,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: ScreenUtilsManager.w4),
          child: Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s15,
              fontWeight: FontWeight.w700,
              color: context.palette.onSurface.withValues(alpha: isDark ? 0.9 : 0.8),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: themeColor,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s16,
              fontWeight: FontWeight.w600,
              color: context.palette.onSurface,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: themeColor.withValues(alpha: isDark ? 0.8 : 0.7),
                size: ScreenUtilsManager.s22,
              ),
              hintText: hint,
              hintStyle: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: context.palette.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              filled: true,
              fillColor: context.palette.surfaceLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                borderSide: BorderSide(
                  color: context.palette.outline.withValues(alpha: isDark ? 0.15 : 0.1),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                borderSide: BorderSide(color: themeColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                borderSide: BorderSide(
                  color: context.palette.error.withValues(alpha: 0.7),
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                borderSide: BorderSide(color: context.palette.error, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilsManager.w18,
                vertical: ScreenUtilsManager.h18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
