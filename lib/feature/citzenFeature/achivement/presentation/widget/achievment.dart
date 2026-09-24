import 'package:carousel_slider/carousel_slider.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/achivement/presentation/achievement/achicvementState.dart';
import 'package:citifix/feature/citzenFeature/achivement/presentation/achievement/achivementManger.dart';
import 'package:citifix/feature/citzenFeature/achivement/presentation/widget/AchievementCard.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/Dotincator.dart';
import 'package:citifix/feature/citzenFeature/achivement/presentation/views/achievementItem.dart';
import '../../../../../generated/l10n.dart';

class AchievemrntReportScreen extends StatefulWidget {
  const AchievemrntReportScreen({super.key});

  @override
  State<AchievemrntReportScreen> createState() =>
      _AchievemrntReportScreenState();
}

class _AchievemrntReportScreenState extends State<AchievemrntReportScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<AchievementCubit>().getAchievements();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isFetchingMore) return;
    setState(() => _isFetchingMore = true);
    await context.read<AchievementCubit>().getAchievements();
    if (mounted) setState(() => _isFetchingMore = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: context.palette.reportsPageBackground,
      body: BlocBuilder<AchievementCubit, AchievementState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
                title: Text(
                  l10n.achievement,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    border: Theme.of(context).brightness == Brightness.dark
                        ? Border(
                            bottom: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.outline.withValues(alpha: 0.1),
                              width: 0.5,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: SizedBox(),
                ),
              ),

              if (state is AchievementLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CupertinoActivityIndicator(radius: 15)),
                )
              else if (state is AchievementError)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildErrorWidget(l10n, state.message),
                )
              else if (state is AchievementSuccess)
                ..._buildSuccessContent(l10n, state)
              else
                const SliverToBoxAdapter(child: SizedBox()),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildSuccessContent(S l10n, AchievementSuccess state) {
    final reports = state.reports;

    if (reports.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(l10n.noData, style: GoogleFonts.cairo(fontSize: 16.sp)),
          ),
        ),
      ];
    }

    final topReports = reports.where((e) => e.isTopAchievement).toList();

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(l10n.topAchievements),
              SizedBox(height: 12.h),
              if (topReports.isNotEmpty) ...[
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: topReports.length,
                  options: CarouselOptions(
                    height: ScreenUtilsManager.h200,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, _) =>
                        setState(() => _currentIndex = index),
                  ),
                  itemBuilder: (context, index, _) =>
                      AchievementCard(report: topReports[index]),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: DotIndicator(
                    itemCount: topReports.length,
                    currentIndex: _currentIndex,
                    onTap: (index) => _carouselController.animateToPage(index),
                  ),
                ),
              ],
              SizedBox(height: 24.h),
              _sectionTitle(l10n.resolvedReports),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),

      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index == reports.length) {
              return state.hasMore
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const CupertinoActivityIndicator(),
                    )
                  : SizedBox(height: 40.h);
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: AchievementReportCard(report: reports[index]),
            );
          }, childCount: reports.length + 1),
        ),
      ),
    ];
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ScreenUtilsManager.s18,
        fontWeight: FontWeight.w800,
        color: context.palette.onSurface,
      ),
    );
  }

  Widget _buildErrorWidget(S l10n, String message) {
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
            l10n.errorOccurred,
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
            onPressed: () => context.read<AchievementCubit>().getAchievements(),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.palette.primary,
              foregroundColor: context.palette.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
