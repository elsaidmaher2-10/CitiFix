import 'package:citifix/App/manager/cubit/localization_controller_cubit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void showLanguagePicker(BuildContext context, bool isWorekr) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
      ),
      backgroundColor: context.palette.white,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.h24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).selectLanguage,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s20,
                fontWeight: FontWeight.bold,
                color: isWorekr
                    ? context.palette.workerprimary
                    : context.palette.kPrimary,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h10),
            Text(
              S.of(context).choosePreferredLanguage,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s12,
                fontWeight: FontWeight.w400,
                color: context.palette.lightGrey2,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            _buildLanguageOption(
              context,
              title: S.of(context).english,
              langCode: "en",
            ),
            _buildLanguageOption(
              context,
              title: S.of(context).arabic,
              langCode: "ar",
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildLanguageOption(
  BuildContext context, {
  required String title,
  required String langCode,
}) {
  return GestureDetector(
    onTap: () {
      context.read<LocalizationControllerCubit>().changeLanguage(langCode);
      Navigator.pop(context, langCode);
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenUtilsManager.h12),
      margin: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h6),
      decoration: BoxDecoration(
        border: Border.all(
          width: ScreenUtilsManager.w1,
          color: context.palette.lightGrey2.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s14,
          fontWeight: FontWeight.w600,
          color: context.palette.textBlack,
        ),
      ),
    ),
  );
}
