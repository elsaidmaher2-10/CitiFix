import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../resource/colormanager.dart';

class StatusBadgeApp extends StatelessWidget {
  final String status;

  const StatusBadgeApp({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusTheme(status, context);
    final Color color = statusData['color'];
    final String label = statusData['label'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.cairo(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getStatusTheme(String status, BuildContext context) {
    switch (status) {
      case "InProgress":
        return {
          'color': context.palette.kPrimary,
          'label': S.of(context).inProgress,
        };
      case "Resolved":
      case "Completed":
        return {
          'color': const Color(0xFF4CAF50), // Green
          'label': S.of(context).completed,
        };
      case "Assigned":
        return {
          'color': const Color(0xFF3F51B5),
          'label': S.of(context).assigned,
        };
      case "Pending":
        return {
          'color': const Color(0xFFFFA000),
          'label': S.of(context).pending,
        };
      case "Rejected":
        return {'color': const Color(0xFFD32F2F), 'label': "Rejected"};
      default:
        return {
          'color': context.palette.onSurfaceVariant,
          'label': status,
        };
    }
  }
}

