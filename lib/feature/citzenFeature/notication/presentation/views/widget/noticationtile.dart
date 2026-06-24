import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/notication/data/model/notifavtionmodel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/reportdetails.dart';
import 'package:citifix/feature/workerFeature/taskDetails/TaskDetailsPage.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/repos/reportdetails.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/reportdetailsManger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });
  int? extractReportNumber(String message) {
    final match = RegExp(r'#(\d+)').firstMatch(message);

    if (match != null) {
      return int.parse(match.group(1)!);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isWorker =
        PrefrenceManager().getstring("role")?.toLowerCase() == "worker";
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = isWorker
        ? context.palette.workerprimary
        : context.palette.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r15),
        onTap: () {
          onTap();

          if (item.message.contains("report")) {
            final role =
                PrefrenceManager().getstring(Constantmanger.role) ?? "";

            if (role.toLowerCase() == "worker") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (_) => ReportDetailsManager(
                      reportdetailsRepo: getIt<ReportdetailsRepo>(),
                    ),
                    child: TaskDetailsPage(
                      reportid: extractReportNumber(item.message) ?? 2,
                    ),
                  ),
                ),
              );
            } else {
              final reportId = extractReportNumber(item.message);
              if (reportId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportDetailsScreen(
                      reportId: reportId,
                      isachivement: false,
                    ),
                  ),
                );
              }
            }
          }
        },
        highlightColor: primaryColor.withOpacity(0.05),
        splashColor: primaryColor.withOpacity(0.1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(ScreenUtilsManager.w16),
          decoration: BoxDecoration(
            color: item.isRead
                ? context.palette.surface
                : context.palette.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r15),
            border: Border.all(
              color: item.isRead
                  ? context.palette.outline.withOpacity(0.2)
                  : context.palette.primary.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: item.isRead
                ? []
                : [
                    BoxShadow(
                      color: context.palette.primary.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconContainer(context, primaryColor),
              SizedBox(width: ScreenUtilsManager.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: GoogleFonts.cairo(
                              fontSize: ScreenUtilsManager.s16,
                              fontWeight: item.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                              color: item.isRead
                                  ? context.palette.onSurfaceVariant
                                  : context.palette.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          DateTime.parse(item.createdAt).timeAgo(context),
                          style: GoogleFonts.cairo(
                            fontSize: ScreenUtilsManager.s10,
                            fontWeight: item.isRead
                                ? FontWeight.w400
                                : FontWeight.w300,
                            color: item.isRead
                                ? context.palette.onSurfaceVariant
                                : context.palette.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtilsManager.h4),
                    Text(
                      item.message,
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s14,
                        color: item.isRead
                            ? context.palette.onSurfaceVariant.withOpacity(0.7)
                            : context.palette.onSurfaceVariant,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: ScreenUtilsManager.w8),
              _buildDeleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(BuildContext context, Color primaryColor) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(ScreenUtilsManager.w10),
          decoration: BoxDecoration(
            color: item.isRead
                ? context.palette.outline.withOpacity(0.1)
                : primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item.isRead
                ? Icons.notifications_none_rounded
                : Icons.notifications_active_rounded,
            color: item.isRead
                ? context.palette.onSurfaceVariant
                : primaryColor,
            size: ScreenUtilsManager.s20,
          ),
        ),
        if (!item.isRead)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: ScreenUtilsManager.w12,
              height: ScreenUtilsManager.h12,
              decoration: BoxDecoration(
                color: context.palette.red,
                shape: BoxShape.circle,
                border: Border.all(color: context.palette.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onDelete,
        child: Container(
          padding: EdgeInsets.all(ScreenUtilsManager.w8),
          decoration: BoxDecoration(
            color: context.palette.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close_rounded,
            color: context.palette.red,
            size: ScreenUtilsManager.s18,
          ),
        ),
      ),
    );
  }
}
