import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/feature/citzenFeature/notication/notifaction.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/DI/getit.dart';
import '../../../../verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import '../../../../verfication/data/repo/VerficationInitRepo.dart';
import '../../../../verfication/verificationreqeusts.dart';

class WorkerMainscreenAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const WorkerMainscreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.palette.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: ScreenUtilsManager.h70,
      title: Row(
        children: [
          SvgPicture.asset(
            AssetValueManager.Klog,
            height: ScreenUtilsManager.s32,
            width: ScreenUtilsManager.s32,
          ),
          SizedBox(width: ScreenUtilsManager.w12),
          Text(
            S.of(context).appTitle,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s20,
              fontWeight: FontWeight.bold,
              color: context.palette.onSurface,
            ),
          ),
        ],
      ),
      actions: [
        BlocBuilder<NotificationCubit, NotificationState>(
          buildWhen: (previous, current) => current is NotificationLoaded,
          builder: (context, state) {
            int unreadCount = 0;
            if (state is NotificationLoaded) {
              unreadCount = state.notifications.where((e) => !e.isRead).length;
            }
            return Padding(
              padding: EdgeInsets.only(right: ScreenUtilsManager.w8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationCenter(),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtilsManager.w10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: unreadCount > 0
                              ? Lottie.asset(
                                  AssetValueManager.Notificationbell,
                                  key: const ValueKey('lottie_bell'),
                                  width: ScreenUtilsManager.w28,
                                  height: ScreenUtilsManager.h28,
                                )
                              : Icon(
                                  Icons.notifications_rounded,
                                  key: const ValueKey('icon_bell'),
                                  size: ScreenUtilsManager.s26,
                                  color: context.palette.onSurface.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: -ScreenUtilsManager.w2,
                            top: -ScreenUtilsManager.h2,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.elasticOut,
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtilsManager.w5,
                                      vertical: ScreenUtilsManager.h2,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: ScreenUtilsManager.w18,
                                      minHeight: ScreenUtilsManager.h18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.palette.error,
                                      borderRadius: BorderRadius.circular(
                                        ScreenUtilsManager.r10,
                                      ),
                                      border: Border.all(
                                        color: context.palette.surface,
                                        width: ScreenUtilsManager.w1_5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: ScreenUtilsManager.s4,
                                          offset: Offset(
                                            0,
                                            ScreenUtilsManager.h2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        unreadCount > 9 ? '9+' : '$unreadCount',
                                        style: GoogleFonts.cairo(
                                          color: Colors.white,
                                          fontSize: ScreenUtilsManager.s9,
                                          fontWeight: FontWeight.w900,
                                          height: 1.1,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        Padding(
          padding: EdgeInsets.only(right: ScreenUtilsManager.w12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) =>
                          VerificationInitCubit(getIt<VerficationInitRepo>()),
                      child: const VerificationRequestsScreen(),
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
              child: Container(
                padding: EdgeInsets.all(ScreenUtilsManager.w10),
                child: Icon(
                  Icons.menu_rounded,
                  size: ScreenUtilsManager.s26,
                  color: context.palette.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtilsManager.h70);
}
