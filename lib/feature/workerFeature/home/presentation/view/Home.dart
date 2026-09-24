import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/dashbroadHomemanager/cubit/dashbroad_home_manager_cubit.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/dashbroadHomemanager/cubit/dashbroad_home_manager_state.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/customtaskListView.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/CustomMapSection.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/HomeAppBar.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/WorkAllertVrefication.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/WorkerDashBoard.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/workerCard.dart';
import 'package:citifix/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/resource/screenutilsmaanger.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.reportsPageBackground,
      appBar: const WorkerMainscreenAppbar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return buildShimmerLoading(context);
          } else if (state is HomeSuccess) {
            return _buildHomeContent(state.dashboardData, context);
          } else if (state is HomeError) {
            return _buildErrorState(context, state.errorMessage);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w20),
              decoration: BoxDecoration(
                color: context.palette.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: ScreenUtilsManager.s50,
                color: context.palette.error,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              S.of(context).errorTitle,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s18,
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
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w32,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                ),
              ),
              onPressed: () => context.read<HomeCubit>().getWorkerDashboard(),
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

Widget _buildHomeContent(DashBroadHome data, BuildContext context) {
  return RefreshIndicator(
    color: context.palette.workerprimary,
    backgroundColor: context.palette.surface,
    onRefresh: () => context.read<HomeCubit>().getWorkerDashboard(),
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        ScreenUtilsManager.w20,
        ScreenUtilsManager.h20,
        ScreenUtilsManager.w20,
        ScreenUtilsManager.h100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(data.workerName, context),
          SizedBox(height: ScreenUtilsManager.h24),
          WorkerCard(
            isVerified: data.verified,
            name: data.workerName,
            imageUrl: data.profileImageUrl ?? AssetValueManager.defualtimage1,
          ),
          if (!data.verified) ...[
            SizedBox(height: ScreenUtilsManager.h16),
            const WorkerAlertVrefication(),
          ],
          SizedBox(height: ScreenUtilsManager.h32),
          WorkerDashboard(data: data),
          SizedBox(height: ScreenUtilsManager.h32),
          CustomMapSection(
            zonemLevel: data.areaCoordinates,
            areaname: data.areaName,
          ),
          SizedBox(height: ScreenUtilsManager.h32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).recentReport,
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s18,
                  fontWeight: FontWeight.w800,
                  color: context.palette.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
             
            ],
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          data.recentReports.isEmpty
              ? _buildEmptyTasksMessage(context)
              : CustomTaskListView(reports: data.recentReports),
        ],
      ),
    ),
  );
}

Widget _buildHeaderSection(String name, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${S.of(context).welcome_message} $name 👋",
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s22,
          fontWeight: FontWeight.w900,
          color: context.palette.onSurface,
          letterSpacing: -0.8,
          height: 1.1,
        ),
      ),
      SizedBox(height: ScreenUtilsManager.h6),
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilsManager.w10,
          vertical: ScreenUtilsManager.h4,
        ),
        decoration: BoxDecoration(
          color: context.palette.workerprimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
        ),
        child: Text(
          S.of(context).stay_focused,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s13,
            fontWeight: FontWeight.w700,
            color: context.palette.workerprimary,
          ),
        ),
      ),
    ],
  );
}

Widget buildShimmerLoading(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(ScreenUtilsManager.w20),
    child: Shimmer.fromColors(
      baseColor: context.palette.surfaceContainerHigh,
      highlightColor: context.palette.surfaceContainerHighest,
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(bottom: ScreenUtilsManager.h20),
            height: ScreenUtilsManager.h180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.palette.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildEmptyTasksMessage(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(ScreenUtilsManager.w32),
    decoration: BoxDecoration(
      color: context.palette.surface,
      borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
      border: Border.all(color: context.palette.outline.withValues(alpha: 0.1)),
      boxShadow: [
        BoxShadow(
          color: context.palette.shadow,
          blurRadius: ScreenUtilsManager.s20,
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(ScreenUtilsManager.w20),
          decoration: BoxDecoration(
            color: context.palette.workerprimary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.assignment_turned_in_rounded,
            size: ScreenUtilsManager.s48,
            color: context.palette.workerprimary.withValues(alpha: 0.4),
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h20),
        Text(
          S.of(context).no_tasks_available,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w900,
            fontSize: ScreenUtilsManager.s18,
            color: context.palette.onSurface,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h8),
        Text(
          S.of(context).notify_new_tasks,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s14,
            fontWeight: FontWeight.w600,
            color: context.palette.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
      ],
    ),
  );
}
