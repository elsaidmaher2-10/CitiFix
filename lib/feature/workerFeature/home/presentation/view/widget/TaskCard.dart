import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customShimerwidget.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/taskDetails/TaskDetailsPage.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/repos/reportdetails.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/reportdetailsManger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  final RecentReportModel report;

  const TaskCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final statusColor = StatusReport.fromString(report.status).color;
    return Container(
      width: ScreenUtilsManager.w240,
      margin: EdgeInsets.only(right: ScreenUtilsManager.w16, bottom: ScreenUtilsManager.h8),
      padding: EdgeInsets.all(ScreenUtilsManager.w12),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
        border: Border.all(
          color: context.palette.outline.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: ScreenUtilsManager.s15,
            offset: Offset(0, ScreenUtilsManager.h6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => BlocProvider(
                        create: (c) => ReportDetailsManager(
                          reportdetailsRepo: getIt<ReportdetailsRepo>(),
                        ),
                        child: TaskDetailsPage(reportid: report.id),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'task_${report.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return customShimer(context, ScreenUtilsManager.h150);
                      },
                      height: ScreenUtilsManager.h110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: report.imageUrls.isNotEmpty
                          ? report.imageUrls.first
                          : Constantmanger.defualtImage,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtilsManager.h10,
                right: ScreenUtilsManager.w10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.w12,
                    vertical: ScreenUtilsManager.h6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: ScreenUtilsManager.s4,
                      ),
                    ],
                  ),
                  child: Text(
                    report.status,
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: ScreenUtilsManager.s10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.categoryName.toUpperCase(),
                  style: GoogleFonts.cairo(
                    color: context.palette.workerprimary,
                    fontSize: ScreenUtilsManager.s10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h2),
                Text(
                  report.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w800,
                    fontSize: ScreenUtilsManager.s15,
                    color: context.palette.onSurface,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h10),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ScreenUtilsManager.w4),
                      decoration: BoxDecoration(
                        color: context.palette.onSurfaceVariant.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        size: ScreenUtilsManager.s14,
                        color: context.palette.workerprimary,
                      ),
                    ),
                    SizedBox(width: ScreenUtilsManager.w6),
                    Expanded(
                      child: Text(
                        report.areaName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s12,
                          color: context.palette.onSurfaceVariant.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilsManager.w8),
                    Text(
                      "${report.createdAt.day}/${report.createdAt.month}",
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s11,
                        color: context.palette.onSurfaceVariant.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
