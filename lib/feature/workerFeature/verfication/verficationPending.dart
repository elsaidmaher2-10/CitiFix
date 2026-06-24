import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/WorkerRequestModel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:citifix/feature/workerFeature/verfication/verificationreqeusts.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderReviewScreen extends StatelessWidget {
  final WorkerRequestModel workerRequestModel;

  const UnderReviewScreen({super.key, required this.workerRequestModel});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: context.palette.bgbackground,
      appBar: _buildAppBar(context, s),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilsManager.p24,
            vertical: ScreenUtilsManager.p32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeaderSection(context, s),
                  SizedBox(height: ScreenUtilsManager.p24),
                  _buildSummarySection(context, s, workerRequestModel),
                  SizedBox(height: ScreenUtilsManager.p24),
                  _buildWhatsNextSection(context, s),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, S s) {
    return AppBar(
      backgroundColor: context.palette.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtilsManager.w1),
        child: Container(
          color: context.palette.outline.withOpacity(0.1),
          height: ScreenUtilsManager.w1,
        ),
      ),
      title: Text(
        s.appTitle,
        style: GoogleFonts.cairo(
          color: context.palette.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtilsManager.s18,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.p16),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        VerificationInitCubit(getIt<VerficationInitRepo>()),
                    child: const VerificationRequestsScreen(),
                  ),
                ),
              );
            },
            child: Text(
              s.verification,
              style: GoogleFonts.cairo(
                color: context.palette.workerprimary,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtilsManager.s16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(BuildContext context, S s) {
    return Column(
      children: [
        Container(
          width: ScreenUtilsManager.s96,
          height: ScreenUtilsManager.s96,
          decoration: BoxDecoration(
            color: context.palette.workerprimary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.schedule,
            size: ScreenUtilsManager.s48,
            color: context.palette.workerprimary,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.p24),
        Text(
          s.underReview,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s32,
            fontWeight: FontWeight.w800,
            color: context.palette.onSurface,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.p12),
        Text(
          s.reviewDesc,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s16,
            color: context.palette.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(
    BuildContext context,
    S s,
    WorkerRequestModel workerRequestModel,
  ) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.p32),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // FIX: Wrap the text in Expanded to prevent horizontal overflow
              Expanded(
                child: Text(
                  s.submissionSummary,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s20,
                    fontWeight: FontWeight.bold,
                    color: context.palette.onSurface,
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilsManager.p8), // Add a little gap
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.p12,
                  vertical: ScreenUtilsManager.h4,
                ),
                decoration: BoxDecoration(
                  color: context.palette.workerprimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                ),
                child: Text(
                  s.inProgress,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s10,
                    fontWeight: FontWeight.bold,
                    color: context.palette.workerprimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilsManager.p32),
          _buildInfoField(context, s.accessZone, workerRequestModel.areaName),
          SizedBox(height: ScreenUtilsManager.p16),
          _buildInfoField(
            context,
            s.department,
            workerRequestModel.departmentName,
          ),
          SizedBox(height: ScreenUtilsManager.p24),
          Text(
            s.identityDocs,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s10,
              fontWeight: FontWeight.bold,
              color: context.palette.onSurfaceVariant,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.p8),
          Row(
            children: [
              Expanded(
                child: _buildDocumentPlaceholder(
                  context,
                  workerRequestModel.nationalIdFrontImageUrl,
                ),
              ),
              SizedBox(width: ScreenUtilsManager.p12),
              Expanded(
                child: _buildDocumentPlaceholder(
                  context,
                  workerRequestModel.nationalIdBackImageUrl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s10,
            fontWeight: FontWeight.bold,
            color: context.palette.onSurfaceVariant,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.p8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(ScreenUtilsManager.p16),
          decoration: BoxDecoration(
            color: context.palette.surfaceContainerLow,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
            border: Border.all(color: context.palette.outline.withOpacity(0.2)),
          ),
          child: Text(
            value,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w600,
              color: context.palette.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentPlaceholder(BuildContext context, String imgurl) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.palette.surfaceContainerLow,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
          border: Border.all(color: context.palette.outline.withOpacity(0.2)),
        ),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imgurl,
          placeholder: (context, url) =>
              const Center(child: CupertinoActivityIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error_outline),
        ),
      ),
    );
  }

  Widget _buildWhatsNextSection(BuildContext context, S s) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.p24),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
        border: Border.all(color: context.palette.outline.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtilsManager.p12),
            decoration: BoxDecoration(
              color: context.palette.workerprimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            ),
            child: Icon(
              Icons.info_outline,
              color: context.palette.workerprimary,
            ),
          ),
          SizedBox(width: ScreenUtilsManager.p16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.whatsNext,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s16,
                    fontWeight: FontWeight.bold,
                    color: context.palette.onSurface,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h4),
                Text(
                  s.whatsNextDesc,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s14,
                    color: context.palette.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
