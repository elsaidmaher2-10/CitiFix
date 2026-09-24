import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/core/widget/stautsBageApp.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/ReportResponseModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/CustomTimelineTile.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ReportDetailsAppbar.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/function/show_full_screen_image.dart';
import '../../../../../core/resource/constantmanger.dart';

class AchivementReportDetails extends StatefulWidget {
  final int reportId;
  final bool isachivement;
  const AchivementReportDetails({
    super.key,
    required this.reportId,
    required this.isachivement,
  });

  @override
  State<AchivementReportDetails> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<AchivementReportDetails> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ReportCubit>().getAchievementbyReportID(
      ReportID: widget.reportId,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              context.read<ReportCubit>().fetchReports();
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: context.palette.reportsPageBackground,
        body: BlocBuilder<ReportCubit, ReportManagerState>(
          builder: (context, state) {
            if (state is GetReportsByidLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  radius: ScreenUtilsManager.r12,
                  color: context.palette.kPrimary,
                ),
              );
            } else if (state is GetAchivmentReportsByidSuccess) {
              final report = state.reports;
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  ReportDetailsAppbar(
                    mediaItems: [...report.reportImageUrls],
                    ontap: () => Navigator.pop(context, true),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatusBadgeApp(status: report.status),
                          SizedBox(height: 16.h),
                          Text(
                            report.title,
                            style: GoogleFonts.cairo(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w900,
                              color: context.palette.onSurface,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              _buildInfoChip(
                                context,
                                Icons.category_outlined,
                                report.categoryName,
                              ),
                              SizedBox(width: 16.w),
                              _buildInfoChip(
                                context,
                                Icons.access_time_rounded,
                                report.createdAt.timeAgo(context),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),

                          _buildUserCard(
                            context,
                            label: S.of(context).reportedBy,
                            name: report.citizenName,
                            userId: report.citizenId.toString(),
                            imageUrl:
                                report.citizenProfileImageUrl ??
                                Constantmanger.defualtImage,
                            icon: Icons.person_outline,
                          ),

                          if (report.workerName.isNotEmpty) ...[
                            SizedBox(height: 12.h),
                            _buildUserCard(
                              context,
                              label: S.of(context).assigned,
                              name: report.workerName,
                              userId: report.workerId.toString(),
                              imageUrl:
                                  report.workerProfileImageUrl ??
                                  Constantmanger.defualtImage,
                              icon: Icons.engineering_outlined,
                              isWorker: true,
                              department: report.departmentName,
                            ),
                          ],

                          SizedBox(height: 20.h),
                          _sectionTitle(S.of(context).description),
                          SizedBox(height: 8.h),
                          Text(
                            report.description,
                            style: GoogleFonts.cairo(
                              fontSize: 15.sp,
                              color: context.palette.onSurface.withValues(
                                alpha: 0.88,
                              ),
                              height: 1.6,
                            ),
                          ),

                          SizedBox(height: 24.h),
                          _sectionTitle(S.of(context).location),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14.sp,
                                color: Colors.red,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  "${report.areaName} - ${report.location}",
                                  style: GoogleFonts.cairo(
                                    fontSize: 13.sp,
                                    color: context.palette.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          _buildMapSection(
                            LatLng(report.latitude, report.longitude),
                            report.location,
                          ),

                          SizedBox(height: 24.h),
                          _sectionTitle(S.of(context).progressTracking),
                          SizedBox(height: 12.h),
                          _buildTimeline(
                            context,
                            report.status,
                            report.timeline,
                          ),
                          SizedBox(height: 24.h),
                          const Divider(),

                          if ((report.completionNote != null &&
                                  report.completionNote!.isNotEmpty) ||
                              report.reportImageUrls.isNotEmpty ||
                              report.completionImageUrls.isNotEmpty) ...[
                            SizedBox(height: 12.h),
                            _sectionTitle(S.of(context).completionDetails),
                            SizedBox(height: 12.h),

                            if (report.completionNote != null &&
                                report.completionNote!.isNotEmpty) ...[
                              _buildCompletionNote(
                                context,
                                report.completionNote!,
                              ),
                              SizedBox(height: 16.h),
                            ],

                            if (report.reportImageUrls.isNotEmpty)
                              _buildImageGallery(
                                context,
                                S.of(context).reportedImages,
                                report.reportImageUrls,
                              ),

                            if (report.completionImageUrls.isNotEmpty)
                              _buildImageGallery(
                                context,
                                S.of(context).completionImages,
                                report.completionImageUrls,
                              ),

                            SizedBox(height: 24.h),
                            const Divider(),
                          ],
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 50.h)),
                ],
              );
            } else if (state is GetReportsByidFailure) {
              return Center(child: _buildErrorWidget(state.errMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildUserCard(
    BuildContext context, {
    required String label,
    required String name,
    String? userId,
    required String imageUrl,
    required IconData icon,
    bool isWorker = false,
    String? department,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isWorker
            ? context.palette.kPrimary.withValues(alpha: 0.12)
            : context.palette.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isWorker
              ? context.palette.kPrimary.withValues(alpha: 0.28)
              : context.palette.outline.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => showFullScreenImage(context, imageUrl),
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: context.palette.kPrimary.withValues(alpha: 0.15),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: 40.r,
                  height: 40.r,
                  errorWidget: (context, url, error) =>
                      Icon(icon, color: context.palette.kPrimary),
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.cairo(
                    fontSize: 11.sp,
                    color: context.palette.onSurfaceVariant,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: context.palette.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (userId != null && userId.isNotEmpty)
                      Text(
                        "#$userId",
                        style: GoogleFonts.cairo(
                          fontSize: 10.sp,
                          color: context.palette.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                  ],
                ),
                if (isWorker && department != null)
                  Text(
                    department,
                    style: GoogleFonts.cairo(
                      fontSize: 11.sp,
                      color: context.palette.kPrimary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: context.palette.kPrimary,
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.sp, color: context.palette.onSurfaceVariant),
        SizedBox(width: 4.w),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 13.sp,
            color: context.palette.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(
    BuildContext context,
    String currentStatus,
    List<TimelineModel> timeline,
  ) {
    int currentIndex = StatusReport.fromString(currentStatus).index;
    return Column(
      children: List.generate(4, (index) {
        String dateText = "";
        if (index < timeline.length) {
          dateText = DateTime.parse(timeline[index].date).timeAgo(context);
        }
        return CustomTimelineTile(
          title: _getStepTitle(context, index),
          isFirst: index == 0,
          isLast: index == 3,
          isDone: currentIndex >= index,
          timeline: dateText,
        );
      }),
    );
  }

  String _getStepTitle(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).pending;
      case 1:
        return S.of(context).assigned;
      case 2:
        return S.of(context).inProgress;
      case 3:
        return S.of(context).resolved;
      default:
        return "";
    }
  }

  Widget _buildMapSection(LatLng apiPosition, String location) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        child: CustomMap.fromAPI(
          location: location,
          onmapCreated: (d, latlang) {},
          apiPosition: apiPosition,
        ),
      ),
    );
  }

  Widget _buildCompletionNote(BuildContext context, String note) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.palette.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.palette.outline.withValues(alpha: 0.45),
        ),
      ),
      child: Text(
        note,
        style: GoogleFonts.cairo(
          fontSize: 14.sp,
          color: context.palette.onSurface,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildImageGallery(
    BuildContext context,
    String title,
    List<String> images,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: context.palette.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: GestureDetector(
                  onTap: () => showFullScreenImage(context, images[index]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CachedNetworkImage(
                      imageUrl: images[index],
                      width: 90.w,
                      height: 90.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 90.w,
                        color: context.palette.surfaceContainerLow,
                        child: const CupertinoActivityIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 90.w,
                        color: context.palette.surfaceContainerLow,
                        child: Icon(
                          Icons.broken_image,
                          color: context.palette.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildErrorWidget(String message) {
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
            style: GoogleFonts.cairo(color: context.palette.onSurfaceVariant),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<ReportCubit>().GetReportByID(
              ReportID: widget.reportId,
            ),
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
}
