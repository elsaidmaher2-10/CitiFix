import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/reportdetails.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/vedioplayer.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/widget/stautsBageApp.dart';
import 'deleteReportDialog.dart';

class Reportcard extends StatelessWidget {
  final ReportItem report;

  const Reportcard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ReportDetailsScreen(reportId: report.id, isachivement: false),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Slidable(
          key: ValueKey(report.id),
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
            height: 108.h,
            decoration: BoxDecoration(
              color: context.palette.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 11.w),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: _buildMediaPreview(),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          report.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            color: context.palette.onSurface,
                            fontSize: ScreenUtilsManager.s16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        _buildInfoRow(
                          context,
                          Icons.place_outlined,
                          report.location,
                        ),
                        _buildInfoRow(
                          context,
                          Icons.watch_later_outlined,
                          report.createdAt.timeAgo(context),
                        ),
                      ],
                    ),
                  ),
                  StatusBadgeApp(status: report.status),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    if (report.imagesUrls.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: report.imagesUrls.first,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
        fit: BoxFit.cover,
      );
    } else if (report.videosUrls.isNotEmpty) {
      return AppVideoPlayer(
        dataSource: report.videosUrls.first,
        isRemote: true,
      );
    } else {
      return Image.network(Constantmanger.defualtImage, fit: BoxFit.cover);
    }
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14.h, color: context.palette.onSurfaceVariant),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cairo(
              color: context.palette.onSurfaceVariant,
              fontSize: ScreenUtilsManager.s12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
