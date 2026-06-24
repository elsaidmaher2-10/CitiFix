import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/MainscreenAppbar.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/GetAllReport.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ReportCard.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/statusCard.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.reportsPageBackground,
      appBar: const MainscreenAppbar(),
      body: BlocBuilder<ReportCubit, ReportManagerState>(
        builder: (context, state) {
          if (state is GetReportsLoading || state is deleteReportState) {
            return Center(
              child: SpinKitWaveSpinner(color: context.palette.lightColor),
            );
          }
          if (state is GetReportsFailure) {
            return Center(child: _buildErrorWidget(context, state.errMessage));
          }
          List<ReportItem> reports = [];
          if (state is GetReportsSuccess) {
            reports = state.reports;
          }

          final int completedCount = reports
              .where((e) => e.status.toLowerCase() == "resolved")
              .length;
          final int pendingCount = reports
              .where((e) => e.status.toLowerCase() == "pending")
              .length;
          final int activeCount = reports
              .where((e) => e.status.toLowerCase() == "assigned")
              .length;

          return RefreshIndicator.adaptive(
            backgroundColor: context.palette.surfaceContainerLowest,
            color: context.palette.kPrimary,
            onRefresh: () async {
              await context.read<ReportCubit>().fetchReports(isRefresh: true);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtilsManager.h20),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.w16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(ScreenUtilsManager.w8),
                          decoration: BoxDecoration(
                            color: context.palette.kPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                          ),
                          child: SvgPicture.asset(
                            AssetValueManager.overVeiw,
                            height: 20.h,
                            width: 20.w,
                            colorFilter: ColorFilter.mode(
                              context.palette.kPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtilsManager.w10),
                        Text(
                          S.of(context).overview,
                          style: GoogleFonts.cairo(
                            letterSpacing: -0.5,
                            color: context.palette.onSurface,
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtilsManager.s22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilsManager.h16),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.w16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: StatusCard(
                            color: context.palette.kPrimary,
                            number: activeCount,
                            title: S.of(context).assigned,
                            iconPath: AssetValueManager.active,
                            iconcolor: context.palette.kPrimary,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: StatusCard(
                            color: context.palette.orange,
                            number: pendingCount,
                            title: S.of(context).pending,
                            iconPath: AssetValueManager.pending,
                            iconcolor: context.palette.orange,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: StatusCard(
                            number: completedCount,
                            title: S.of(context).completed,
                            iconPath: AssetValueManager.resolved,
                            color: context.palette.green,
                            iconcolor: context.palette.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ScreenUtilsManager.h32),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.w16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).recentReport,
                          style: GoogleFonts.cairo(
                            fontSize: ScreenUtilsManager.s18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                            color: context.palette.onSurface,
                          ),
                        ),
                        if (reports.isNotEmpty)
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: context.palette.kPrimary,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              backgroundColor: context.palette.kPrimary.withOpacity(0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ReportCubit>(),
                                    child: ReportsPage(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).seeAll,
                              style: GoogleFonts.cairo(
                                fontSize: ScreenUtilsManager.s12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: ScreenUtilsManager.h16),

                  if (reports.isEmpty)
                    _buildEmptyState(context)
                  else
                    ListView.separated(
                      key: ValueKey(reports.length),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: ScreenUtilsManager.w16,
                        right: ScreenUtilsManager.w16,
                        bottom: ScreenUtilsManager.h40,
                      ),
                      itemCount: reports.length > 3 ? 3 : reports.length,
                      itemBuilder: (context, index) =>
                          Reportcard(report: reports[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: ScreenUtilsManager.h12),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h60),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w24),
              decoration: BoxDecoration(
                color: context.palette.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.palette.outline.withOpacity(0.1),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.palette.shadow,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 56.r,
                color: context.palette.kPrimary.withOpacity(0.4),
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              S.of(context).noRecentReports,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s18,
                fontWeight: FontWeight.w800,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w40),
              child: Text(
                S.of(context).emptyReportsSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s14,
                  fontWeight: FontWeight.w600,
                  color: context.palette.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildErrorWidget(BuildContext context, String message) {
  return Padding(
    padding: EdgeInsets.all(20.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        message.contains(Constantmanger.nointernet)
            ? Icon(
                Icons.cloud_off,
                size: 64.w,
                color: context.palette.onSurfaceVariant,
              )
            : Icon(
                Icons.error,
                size: 64.w,
                color: context.palette.onSurfaceVariant,
              ),
        SizedBox(height: 16.h),
        Text(
          S.of(context).errorOccurred,
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: context.palette.onSurface,
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            color: context.palette.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 16.h),
        ElevatedButton(
          onPressed: () => context.read<ReportCubit>().fetchReports(),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.palette.primary,
            foregroundColor: context.palette.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(S.of(context).retry),
        ),
      ],
    ),
  );
}
