import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerAlertVrefication extends StatelessWidget {
  const WorkerAlertVrefication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.h16),
      decoration: BoxDecoration(
        color: context.palette.orange.withValues(alpha: 0.08),
        border: Border.all(color: context.palette.orange.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtilsManager.w10),
            decoration: BoxDecoration(
              color: context.palette.orange.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: context.palette.orange,
              size: ScreenUtilsManager.icon24,
            ),
          ),
          SizedBox(width: ScreenUtilsManager.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).alertRequired,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w800,
                    fontSize: ScreenUtilsManager.s15,
                    color: context.palette.orange,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h2),
                Text(
                  S.of(context).updateYourId,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s13,
                    fontWeight: FontWeight.w600,
                    color: context.palette.onSurfaceVariant.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
