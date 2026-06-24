import 'dart:async';

import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/resource/colormanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/VerificationrequestModel.dart';

Widget buildBottomBar(
  StreamController<bool> stream,
  VerificationrequestModel? request,
) {
  return StreamBuilder<bool>(
    stream: stream.stream,
    initialData: false,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      bool isEnabled = snapshot.data == true && request != null;
      return Container(
        padding: EdgeInsets.fromLTRB(
          ScreenUtilsManager.w24,
          ScreenUtilsManager.h16,
          ScreenUtilsManager.w24,
          ScreenUtilsManager.h40,
        ),
        decoration: BoxDecoration(
          color: context.palette.surface,
          boxShadow: [
            BoxShadow(
              color: context.palette.shadow,
              blurRadius: ScreenUtilsManager.s10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isEnabled
              ? () {
                  context.read<VerificationInitCubit>().sendVerificationRequest(
                    request: request,
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.palette.workerprimary,
            disabledBackgroundColor: context.palette.outline.withOpacity(0.12),
            minimumSize: Size(double.infinity, ScreenUtilsManager.h56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r18),
            ),
            elevation: isEnabled ? 2 : 0,
          ),
          child: Text(
            S.of(context).verifyNow,
            style: GoogleFonts.cairo(
              color: isEnabled
                  ? Colors.white
                  : context.palette.onSurfaceVariant.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s16,
            ),
          ),
        ),
      );
    },
  );
}
