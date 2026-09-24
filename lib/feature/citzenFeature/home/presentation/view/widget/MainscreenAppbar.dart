import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/notication/notifaction.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_state.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MainscreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainscreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      backgroundColor: context.palette.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: Border(
        bottom: BorderSide(
          color: context.palette.outline.withValues(alpha: isDark ? 0.1 : 0.05),
          width: 1,
        ),
      ),
      automaticallyImplyLeading: false,
      toolbarHeight: ScreenUtilsManager.h61,
      titleSpacing: ScreenUtilsManager.w16,

      title: Row(
        children: [
          SvgPicture.asset(
            AssetValueManager.Klog,
            width: ScreenUtilsManager.w24,
            height: ScreenUtilsManager.w24,
          ),

          SizedBox(width: ScreenUtilsManager.w12),

          Text(
            S.of(context).appTitle,
            style: GoogleFonts.cairo(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
              fontSize: ScreenUtilsManager.s18,
              letterSpacing: -0.3,
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
              padding: EdgeInsets.only(right: ScreenUtilsManager.w12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationCenter(),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtilsManager.w8),
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
                                  width: 28,
                                  height: 28,
                                )
                              : Icon(
                                  Icons.notifications_none_rounded,
                                  key: const ValueKey('icon_bell'),
                                  size: 26,
                                  color: context.palette.onSurface.withValues(
                                    alpha: 0.85,
                                  ),
                                ),
                        ),

                        if (unreadCount > 0)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.elasticOut,
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 2,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 18,
                                      minHeight: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xffFF5252),
                                          Color(0xffFF1744),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: context.palette.surface,
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.15),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        unreadCount > 9 ? '9+' : '$unreadCount',
                                        style: GoogleFonts.cairo(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
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
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtilsManager.h61);
}
