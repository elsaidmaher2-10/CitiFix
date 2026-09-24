import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildWorkerCard(
  BuildContext context, {
  required String label,
  required String value,
  IconData? icon,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(ScreenUtilsManager.w16),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        border: Border.all(
          color: context.palette.outline.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: ScreenUtilsManager.s20,
            offset: Offset(0, ScreenUtilsManager.h8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w10),
              decoration: BoxDecoration(
                color: context.palette.workerprimary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
              ),
              child: Icon(
                icon,
                color: context.palette.workerprimary,
                size: ScreenUtilsManager.s20,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h16),
          ],
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s12,
              fontWeight: FontWeight.w700,
              color: context.palette.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h4),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s22,
              fontWeight: FontWeight.w900,
              color: context.palette.onSurface,
            ),
          ),
        ],
      ),
    ),
  );
}
