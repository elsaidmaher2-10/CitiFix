import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildStatusBadge(String text) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: ScreenUtilsManager.w12,
      vertical: ScreenUtilsManager.h4,
    ),
    decoration: BoxDecoration(
      color: StatusReport.values
          .firstWhere((e) => e.value == text)
          .color
          .withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconStatus(StatusReport.fromString(text)),
        SizedBox(width: ScreenUtilsManager.w4),
        Text(
          text,
          style: GoogleFonts.cairo(
            color: StatusReport.values.firstWhere((e) => e.value == text).color,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtilsManager.s12,
          ),
        ),
      ],
    ),
  );
}

Widget iconStatus(StatusReport status) {
  switch (status) {
    case StatusReport.pending:
      return SvgPicture.asset(
        AssetValueManager.pending,
        colorFilter: const ColorFilter.mode(Color(0xFFFFB300), BlendMode.srcIn),
      );

    case StatusReport.assigned:
      return SvgPicture.asset(
        AssetValueManager.active,
        colorFilter: const ColorFilter.mode(Color(0xFF3F51B5), BlendMode.srcIn),
      );

    case StatusReport.inProgress:
      return SvgPicture.asset(
        AssetValueManager.active,
        colorFilter: ColorFilter.mode(ColorManger.kPrimary, BlendMode.srcIn),
      );

    case StatusReport.resolved:
    case StatusReport.completed:
      return SvgPicture.asset(
        AssetValueManager.resolved,
        colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
      );

    case StatusReport.rejected:
      return SvgPicture.asset(
        AssetValueManager.resolved,
        colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      );
  }
}
