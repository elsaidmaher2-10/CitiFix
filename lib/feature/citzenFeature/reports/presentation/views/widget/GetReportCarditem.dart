import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/stautsBageApp.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/reportdetails.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'deleteReportDialog.dart';

class ReportCardIem extends StatelessWidget {
  final ReportItem report;
  final Color statusColor;

  const ReportCardIem({
    super.key,
    required this.report,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),

        children: [
          SlidableAction(
            onPressed: (context) async {
              await showDeleteDialog(context, ReportID: report.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: context.palette.onPrimary,
            icon: Icons.delete,

            label: S.of(context).delete,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: Theme.of(context).brightness == Brightness.dark ? 0.2 : 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtilsManager.h16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: ScreenUtilsManager.h8),
                        StatusBadgeApp(status: report.status),
                        SizedBox(height: ScreenUtilsManager.h8),
                        Text(
                          report.title,
                          style: GoogleFonts.cairo(
                            fontSize: ScreenUtilsManager.s18,
                            fontWeight: FontWeight.bold,
                            color: context.palette.onSurface,
                          ),
                        ),
                        SizedBox(height: ScreenUtilsManager.h6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 14,
                              color: context.palette.red,
                            ),
                            SizedBox(width: ScreenUtilsManager.w4),
                            Expanded(
                              child: Text(
                                report.location,
                                style: GoogleFonts.cairo(
                                  fontSize: ScreenUtilsManager.s12,
                                  color: context.palette.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtilsManager.h12),
                        Text(
                          '${S.of(context).submitted} ${report.createdAt.timeAgo(context)}',
                          style: GoogleFonts.cairo(
                            fontSize: ScreenUtilsManager.s11,
                            color: context.palette.onSurfaceVariant.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenUtilsManager.w12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          CupertinoActivityIndicator(
                            color: context.palette.kPrimary,
                          ),
                      width: ScreenUtilsManager.w80,
                      height: ScreenUtilsManager.h80,
                      fit: BoxFit.cover,
                      imageUrl: report.imagesUrls.isNotEmpty
                          ? report.imagesUrls.first
                          : Constantmanger.defualtImage,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilsManager.w16,
                vertical: ScreenUtilsManager.h12,
              ),
              decoration: BoxDecoration(
                color: context.palette.surfaceContainerLow,
                border: Border(
                  top: BorderSide(
                    color: context.palette.outline.withValues(alpha: 0.15),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${S.of(context).reference} ${report.id.toString().padLeft(5, '0')}',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: context.palette.onSurfaceVariant,
                    ),
                  ),
                  Material(
                    color: context.palette.kPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                    child: InkWell(
                      onTap: () async {
                        final reportCubit = context.read<ReportCubit>();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportDetailsScreen(
                              reportId: report.id,
                              isachivement: false,
                            ),
                          ),
                        );
                        if (context.mounted) {
                          await reportCubit.fetchReports();
                        }
                      },
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r8,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilsManager.w12,
                          vertical: ScreenUtilsManager.h6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.of(context).details,
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtilsManager.s12,
                                color: context.palette.kPrimary,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Directionality.of(context) == TextDirection.rtl
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                              size: ScreenUtilsManager.h16,
                              color: context.palette.kPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
