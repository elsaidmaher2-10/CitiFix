import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customShimerwidget.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:citifix/feature/workerFeature/verfication/pageCheckverfiaction.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerCard extends StatelessWidget {
  final bool isVerified;
  final String name;
  final String imageUrl;

  const WorkerCard({
    super.key,
    required this.isVerified,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
        border: Border.all(
          color: context.palette.outline.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: ScreenUtilsManager.s20,
            offset: Offset(0, ScreenUtilsManager.h10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.w20),
        child: Column(
          children: [
            Row(
              children: [
                _buildWorkerImage(context),
                SizedBox(width: ScreenUtilsManager.w16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameAndBadge(context),
                      SizedBox(height: ScreenUtilsManager.h4),
                      _buildVerificationBadge(context),
                      SizedBox(height: ScreenUtilsManager.h6),
                      _buildOnlineStatus(context),
                    ],
                  ),
                ),
              ],
            ),
            if (!isVerified) ...[
              SizedBox(height: ScreenUtilsManager.h20),
              _buildVerifyButton(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.w2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.palette.orange, width: 2),
      ),
      child: Container(
        padding: EdgeInsets.all(ScreenUtilsManager.w2),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r32),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: ScreenUtilsManager.w56,
            height: ScreenUtilsManager.h56,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                customShimer(context, ScreenUtilsManager.h56),
            errorWidget: (context, url, error) =>
                Icon(Icons.person, size: ScreenUtilsManager.s32, color: context.palette.onSurfaceVariant),
          ),
        ),
      ),
    );
  }

  Widget _buildNameAndBadge(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            name,
            textScaler: TextScaler.noScaling,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s18,
              fontWeight: FontWeight.bold,
              color: context.palette.onSurface,
            ),
          ),
        ),
        if (isVerified) ...[
          SizedBox(width: ScreenUtilsManager.w6),
          SvgPicture.asset(
            "assets/verified-symbol-icon.svg",
            width: ScreenUtilsManager.w20,
            colorFilter: ColorFilter.mode(context.palette.success, BlendMode.srcIn),
          ),
        ],
      ],
    );
  }

  Widget _buildVerificationBadge(BuildContext context) {
    final Color badgeColor = isVerified ? context.palette.success : context.palette.orange;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.w10,
        vertical: ScreenUtilsManager.h2,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        border: Border.all(color: badgeColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        isVerified ? S.of(context).verified : S.of(context).pending,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s10,
          fontWeight: FontWeight.w800,
          color: badgeColor,
        ),
      ),
    );
  }

  Widget _buildOnlineStatus(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ScreenUtilsManager.w8,
          height: ScreenUtilsManager.h8,
          decoration: BoxDecoration(
            color: context.palette.success,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.palette.success.withValues(alpha: 0.4),
                blurRadius: ScreenUtilsManager.s4,
              ),
            ],
          ),
        ),
        SizedBox(width: ScreenUtilsManager.w6),
        Text(
          S.of(context).online,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s14,
            fontWeight: FontWeight.w600,
            color: context.palette.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtilsManager.h48,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.palette.workerprimary,
              context.palette.workerprimary.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
          boxShadow: [
            BoxShadow(
              color: context.palette.workerprimary.withValues(alpha: 0.25),
              blurRadius: ScreenUtilsManager.s12,
              offset: Offset(0, ScreenUtilsManager.h4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                      VerificationInitCubit(getIt<VerficationInitRepo>()),
                  child: const pageCheckVerication(),
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
            ),
          ),
          child: Text(
            S.of(context).verifyNow,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
