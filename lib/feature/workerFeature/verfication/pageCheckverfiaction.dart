import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/verficationinitState.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:citifix/feature/workerFeature/verfication/verficationPending.dart';
import 'package:citifix/feature/workerFeature/verfication/verficationinit.dart';
import 'package:citifix/feature/workerFeature/verfication/vericationField.dart';
import 'package:citifix/feature/workerFeature/verfication/vericationSuccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/resource/screenutilsmaanger.dart';
import '../../../generated/l10n.dart';

class pageCheckVerication extends StatelessWidget {
  const pageCheckVerication({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VerificationInitCubit(getIt<VerficationInitRepo>())
            ..getVerificationRequestData(),
      child: const _GateVerificationBody(),
    );
  }
}

class _GateVerificationBody extends StatelessWidget {
  const _GateVerificationBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationInitCubit, VerificationInitState>(
      listener: (context, state) {
        if (state is VerificationSuccess) {
          final status = VerificationStatus.fromString(
            state.workerRequest.status,
          );

          Widget page;
          switch (status) {
            case VerificationStatus.initial:
              page = BlocProvider(
                create: (context) =>
                    VerificationInitCubit(getIt<VerficationInitRepo>()),
                child: const VerificationInit(),
              );
              break;
            case VerificationStatus.pending:
              page = UnderReviewScreen(workerRequestModel: state.workerRequest);
              break;
            case VerificationStatus.completed:
              page = VerificationCompleteScreen(
                workerRequestModel: state.workerRequest,
              );
              break;
            case VerificationStatus.rejected:
              page = VerificationFailedScreen(
                workerRequestModel: state.workerRequest,
              );
              break;
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => page),
              );
            }
          });
        }

        if (state is VerificationNoRequest) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) =>
                        VerificationInitCubit(getIt<VerficationInitRepo>()),
                    child: const VerificationInit(),
                  ),
                ),
              );
            }
          });
        }

        if (state is VerificationInitError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.palette.bgbackground,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  radius: ScreenUtilsManager.r12,
                  color: context.palette.workerprimary,
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                Text(
                  S.of(context).checking_account_status,
                  style: GoogleFonts.cairo(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
