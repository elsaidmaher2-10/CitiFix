import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/home/presentation/controller/homecontroller.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/workercardDashborad.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerDashboard extends StatefulWidget {
  final DashBroadHome data;
  const WorkerDashboard({super.key, required this.data});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    double initialProgress = HomeDashboardLogic.calculateProgress(widget.data);
    animation = Tween<double>(begin: 0.0, end: initialProgress).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutQuart),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) animationController.forward();
    });
  }

  @override
  void didUpdateWidget(covariant WorkerDashboard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.data.resolvedReports != oldWidget.data.resolvedReports ||
        widget.data.totalReports != oldWidget.data.totalReports) {
      double newProgress = HomeDashboardLogic.calculateProgress(widget.data);
      animation = Tween<double>(begin: animation.value, end: newProgress)
          .animate(
            CurvedAnimation(
              parent: animationController,
              curve: Curves.easeOutQuart,
            ),
          );

      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildWorkerCard(
              context,
              label: S.of(context).resolved,
              value: HomeDashboardLogic.formatNumber(
                widget.data.resolvedReports,
              ),
              icon: Icons.check_circle_outline_rounded,
            ),
            SizedBox(width: ScreenUtilsManager.w16),
            buildWorkerCard(
              context,
              label: S.of(context).assigned,
              value: HomeDashboardLogic.formatNumber(widget.data.totalReports),
              icon: Icons.assignment_outlined,
            ),
          ],
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        Container(
          padding: EdgeInsets.all(ScreenUtilsManager.h20),
          decoration: BoxDecoration(
            color: context.palette.surface,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
            border: Border.all(
              color: context.palette.outline.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: context.palette.shadow,
                blurRadius: ScreenUtilsManager.s20,
                offset: Offset(0, ScreenUtilsManager.h8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).inProgress.toUpperCase(),
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s11,
                          fontWeight: FontWeight.w800,
                          color: context.palette.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        HomeDashboardLogic.formatNumber(
                          widget.data.inProgressReports,
                        ),
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s30,
                          fontWeight: FontWeight.w900,
                          color: context.palette.onSurface,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  _buildTrendIndicator(
                    '+${HomeDashboardLogic.calculateTrend(widget.data)}%',
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilsManager.h24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${S.of(context).totalReports}: ${widget.data.totalReports}',
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s12,
                      fontWeight: FontWeight.w700,
                      color: context.palette.onSurfaceVariant.withValues(alpha: 0.8),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) => Text(
                      '${S.of(context).progress}: ${(animation.value * 100).toInt()}%',
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s12,
                        fontWeight: FontWeight.w800,
                        color: context.palette.workerprimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilsManager.h12),
              AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) =>
                    Stack(
                      children: [
                        Container(
                          height: ScreenUtilsManager.h10,
                          decoration: BoxDecoration(
                            color: context.palette.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: animation.value.clamp(0.0, 1.0),
                          child: Container(
                            height: ScreenUtilsManager.h10,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  context.palette.workerprimary,
                                  context.palette.workerprimary.withValues(alpha: 0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                              boxShadow: [
                                BoxShadow(
                                  color: context.palette.workerprimary.withValues(alpha: 0.3),
                                  blurRadius: ScreenUtilsManager.s6,
                                  offset: Offset(0, ScreenUtilsManager.h2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendIndicator(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.w12,
        vertical: ScreenUtilsManager.h8,
      ),
      decoration: BoxDecoration(
        color: context.palette.success.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
        border: Border.all(color: context.palette.success.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.trending_up_rounded,
            size: ScreenUtilsManager.s16,
            color: context.palette.success,
          ),
          SizedBox(width: ScreenUtilsManager.w6),
          Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s12,
              fontWeight: FontWeight.w900,
              color: context.palette.success,
            ),
          ),
        ],
      ),
    );
  }
}
