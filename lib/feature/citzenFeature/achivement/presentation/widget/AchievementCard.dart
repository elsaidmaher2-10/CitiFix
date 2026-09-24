import 'package:citifix/core/widget/stautsBageApp.dart';
import 'package:citifix/feature/citzenFeature/achivement/data/Achievment/achievementModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AchievementImage.dart';

class AchievementCard extends StatelessWidget {
  final AchievementModel report;
  const AchievementCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
            child: ReportImage(
              url: report.completionImageUrls.first,
              isTop: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: GoogleFonts.cairo(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        report.areaName,
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadgeApp(status: "Resolved"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
