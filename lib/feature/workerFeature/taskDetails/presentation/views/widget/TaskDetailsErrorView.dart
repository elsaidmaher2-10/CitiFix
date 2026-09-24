import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetailsErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const TaskDetailsErrorView({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isNoInternet = error.contains(Constantmanger.nointernet);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.palette.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isNoInternet
                    ? Icons.wifi_off_rounded
                    : Icons.error_outline_rounded,
                size: ScreenUtilsManager.s60,
                color: context.palette.error,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              isNoInternet
                  ? S.of(context).noInternetConnection
                  : S.of(context).somethingWentWrong,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilsManager.s18,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                color: context.palette.onSurfaceVariant,
                fontSize: ScreenUtilsManager.s14,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.palette.workerprimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w32,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                S.of(context).retry,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
