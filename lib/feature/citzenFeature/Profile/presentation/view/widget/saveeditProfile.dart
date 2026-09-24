import 'dart:async';

import 'package:citifix/core/resource/citifix_palette.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Saveeditprofile extends StatelessWidget {
  const Saveeditprofile({
    required this.role,
    super.key,
    required this.ontap,
    required this.bntcontroller,
  });

  final bool role; 
  final Function() ontap;
  final StreamController<bool> bntcontroller;

  @override
  Widget build(BuildContext context) {
    final Color themeColor = role 
        ? context.palette.workerprimary 
        : context.palette.kPrimary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.p23),
      child: SizedBox(
        width: double.infinity,
        child: StreamBuilder<bool>(
          initialData: false,
          stream: bntcontroller.stream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            final bool isEnabled = snapshot.data ?? false;

            return AnimatedScale(
              scale: isEnabled ? 1.0 : 0.98,
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: isEnabled ? ontap : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                  // Improved disabled state
                  disabledBackgroundColor: context.palette.lightGrey.withValues(alpha: 0.5),
                  disabledForegroundColor: context.palette.lightGrey2,
                  
                  padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                  ),
                  
                  elevation: isEnabled ? 8 : 0,
                  shadowColor: themeColor.withValues(alpha: 0.4),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    S.of(context).saveChanges,
                    key: ValueKey<bool>(isEnabled), 
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
