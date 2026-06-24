import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/verficationinitState.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/worker_verification_model.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationRequestsScreen extends StatefulWidget {
  const VerificationRequestsScreen({super.key});

  @override
  State<VerificationRequestsScreen> createState() =>
      _VerificationRequestsScreenState();
}

class _VerificationRequestsScreenState
    extends State<VerificationRequestsScreen> {
  @override
  void initState() {
    super.initState();
    var fetchRequests = context.read<VerificationInitCubit>().fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: context.palette.reportsPageBackground,
      appBar: AppBar(
        leading: IconButton(
          color: context.palette.workerprimary,
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: context.palette.surface,
        title: Text(
          s.verificationRequestsTitle,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: context.palette.workerprimary,
            fontSize: ScreenUtilsManager.s20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<VerificationInitCubit>().fetchRequests(),
            icon: Icon(Icons.refresh, color: context.palette.workerprimary),
          ),
        ],
      ),
      body: BlocBuilder<VerificationInitCubit, VerificationInitState>(
        builder: (context, state) {
          if (state is VerificationRequestsLoading) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: ScreenUtilsManager.r12,
                color: context.palette.workerprimary,
              ),
            );
          } else if (state is VerificationRequestsError) {
            return _buildErrorState(context, state.message);
          } else if (state is VerificationRequestsSuccess) {
            if (state.requests.isEmpty) return _buildEmptyState(s, context);
            return _buildListView(state.requests, s);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildListView(List<WorkerVerificationModel> requests, S s) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.w16,
        vertical: ScreenUtilsManager.h12,
      ),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final item = requests[index];
        return _buildEnhancedCard(item, s, context);
      },
    );
  }

  Widget _buildEnhancedCard(
    WorkerVerificationModel item,
    S s,
    BuildContext context,
  ) {
    final statusColor = _getStatusColor(item.status.name, context);
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilsManager.h20),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        child: Column(
          children: [
            Container(
              height: ScreenUtilsManager.h4,
              color: statusColor.withOpacity(0.5),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtilsManager.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: ScreenUtilsManager.r24,
                        backgroundColor: context.palette.bgbackground,
                        backgroundImage: item.workerProfileImageUrl.isNotEmpty
                            ? NetworkImage(item.workerProfileImageUrl)
                            : null,
                        child: item.workerProfileImageUrl.isEmpty
                            ? Icon(
                                Icons.person,
                                color: context.palette.onSurfaceVariant,
                              )
                            : null,
                      ),
                      SizedBox(width: ScreenUtilsManager.w12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.workerName,
                              style: GoogleFonts.cairo(
                                fontSize: ScreenUtilsManager.s16,
                                fontWeight: FontWeight.bold,
                                color: context.palette.onSurface,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              "${item.id}",
                              style: GoogleFonts.cairo(
                                color: context.palette.onSurfaceVariant,
                                fontSize: ScreenUtilsManager.s12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(context, item.status.name, s),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtilsManager.h12,
                    ),
                    child: Divider(
                      thickness: 0.5,
                      color: context.palette.outline.withOpacity(0.2),
                    ),
                  ),
                  _buildIconInfoRow(
                    Icons.business_center_rounded,
                    item.departmentName,
                    context.palette.primary,
                    context,
                  ),
                  SizedBox(height: ScreenUtilsManager.h8),
                  _buildIconInfoRow(
                    Icons.location_on_rounded,
                    item.areaName,
                    context.palette.red,
                    context,
                  ),
                  SizedBox(height: ScreenUtilsManager.h8),
                  _buildIconInfoRow(
                    Icons.access_time_filled_rounded,
                    DateFormat.yMMMd(
                      Localizations.localeOf(context).languageCode,
                    ).add_jm().format(item.submittedAt),
                    context.palette.orange,
                    context,
                  ),

                  if (item.rejectionReason != null)
                    _buildRejectionBox(item.rejectionReason!, s, context),

                  SizedBox(height: ScreenUtilsManager.h20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconInfoRow(
    IconData icon,
    String text,
    Color iconColor,
    BuildContext context,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(ScreenUtilsManager.w4),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: ScreenUtilsManager.s14, color: iconColor),
        ),
        SizedBox(width: ScreenUtilsManager.w10),
        Text(
          text,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s13,
            color: context.palette.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildRejectionBox(String reason, S s, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtilsManager.h12),
      padding: EdgeInsets.all(ScreenUtilsManager.w12),
      decoration: BoxDecoration(
        color: context.palette.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
        border: Border.all(color: context.palette.red.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: context.palette.red,
            size: ScreenUtilsManager.s18,
          ),
          SizedBox(width: ScreenUtilsManager.w8),
          Expanded(
            child: Text(
              "${s.rejectionReasonLabel}: $reason",
              style: GoogleFonts.cairo(
                color: context.palette.red,
                fontSize: ScreenUtilsManager.s12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'approved':
        return context.palette.success;
      case 'pending':
        return context.palette.orange;
      case 'rejected':
        return context.palette.red;
      default:
        return context.palette.onSurfaceVariant;
    }
  }

  Widget _buildStatusBadge(BuildContext context, String status, S s) {
    final color = _getStatusColor(status, context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.w10,
        vertical: ScreenUtilsManager.h4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.cairo(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtilsManager.s10,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      key: const Key('error'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w20),
              decoration: BoxDecoration(
                color: context.palette.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: ScreenUtilsManager.s50,
                color: context.palette.red,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              S.of(context).errorTitle,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.bold,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: context.palette.onSurfaceVariant,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.palette.workerprimary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w24,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                ),
              ),
              onPressed: () =>
                  context.read<VerificationInitCubit>().fetchRequests(),

              icon: Icon(Icons.refresh_rounded, size: ScreenUtilsManager.s20),
              label: Text(
                S.of(context).tryAgain,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildEmptyState(S s, BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.auto_awesome_motion_rounded,
          size: ScreenUtilsManager.s80,
          color: context.palette.onSurfaceVariant.withOpacity(0.2),
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        Text(
          "All caught up!",
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s20,
            fontWeight: FontWeight.bold,
            color: context.palette.onSurface,
          ),
        ),
        Text(
          "No pending requests at the moment",
          style: GoogleFonts.cairo(color: context.palette.onSurfaceVariant),
        ),
      ],
    ),
  );
}
