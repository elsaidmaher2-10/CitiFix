import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chanagepassword extends StatelessWidget {
  const Chanagepassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.confirmPassword,
          arguments: {"screen": "profile"},
        );
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtilsManager.w16),
        decoration: BoxDecoration(
          color: context.palette.kPrimary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: context.palette.kPrimary,
                  size: ScreenUtilsManager.s20,
                ),
                SizedBox(width: ScreenUtilsManager.w12),
                Text(
                  S.of(context).changePassword,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s14,
                    fontWeight: FontWeight.w600,
                    color: context.palette.kPrimary,
                  ),
                ),
              ],
            ),
            Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? CupertinoIcons.back
                  : CupertinoIcons.forward,
              color: context.palette.kPrimary,
              size: ScreenUtilsManager.s20,
            ),
          ],
        ),
      ),
    );
  }
}
