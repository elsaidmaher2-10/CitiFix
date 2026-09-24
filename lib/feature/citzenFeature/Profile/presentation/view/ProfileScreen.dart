import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/cubit/theme/theme_cubit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/core/cubit/LogOut/LogOutState.dart';
import 'package:citifix/core/cubit/LogOut/LogOutcubit.dart';
import 'package:citifix/core/cubit/controller/imageController.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/ProfileInfo.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/image_picker_menu.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/profileSettings.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/function/imagebutton.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> onLogoutPressed(BuildContext context) async {
    final confirmed = await LogoutConfirmDialog.show(context);
    if (confirmed == true && context.mounted) {
      context.read<LogCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => LogCubit(getIt<LogOutRepository>()),
      child: Scaffold(
        backgroundColor: context.palette.reportsPageBackground,
        appBar: _buildAppBar(context, isDark),
        body: MultiBlocListener(
          listeners: [
            BlocListener<UserProfileInfoCubit, UserProfileInfoState>(
              listener: (context, state) {
                if (state is UserProfileImageUpdatedSuccess ||
                    state is UserProfileInfoError) {
                  ImagePickerController().reset();
                }
              },
            ),
            BlocListener<LogCubit, LogState>(
              listener: (context, state) {
                if (state is LogSuccess) {
                  Customsnackbar.show(
                    backgroundColor: context.palette.green,
                    context: context,
                    message: state.logs,
                  );
                  _clearUserDataAndNavigate(context);
                }
                if (state is LogFailure) {
                  Customsnackbar.show(
                    backgroundColor: context.palette.red,
                    context: context,
                    message: state.failure,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<LogCubit, LogState>(
            builder: (context, logoutState) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ProfileInfo(
                      onTap: () async {
                        final image = await ImagePickerMenu.show(context);
                        if (image != null && context.mounted) {
                          context
                              .read<UserProfileInfoCubit>()
                              .updateUserProfleImage(image);
                        }
                      },
                    ),
                    const Profilesettings(),
                    SizedBox(height: ScreenUtilsManager.h24),
                    _buildLogoutButton(context, logoutState),
                    SizedBox(height: ScreenUtilsManager.h32),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Text(
        S.of(context).profile,
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
          border: isDark
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
    );
  }

  Widget _buildLogoutButton(BuildContext context, LogState logoutState) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLoading = logoutState is LogLoading;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w32),
      child: isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                color: context.palette.kPrimary,
                radius: ScreenUtilsManager.r12,
              ),
            )
          : CustomButton(
              onPressed: () => onLogoutPressed(context),
              icon: const Icon(Icons.logout_rounded),
              backgroundColor: isDark
                  ? context.palette.error.withValues(alpha: 0.15)
                  : context.palette.redLight,
              foregroundColor: context.palette.red,
              lable: S.of(context).logout,
            ),
    );
  }

  void _clearUserDataAndNavigate(BuildContext context) {
    PrefrenceManager().remove(Constantmanger.refreshToken);
    PrefrenceManager().remove(Constantmanger.accessToken);
    PrefrenceManager().remove(Constantmanger.cacheKey);
    PrefrenceManager().remove(Constantmanger.themeModePrefKey);
    PrefrenceManager().remove(Constantmanger.role);
    PrefrenceManager().remove(Constantmanger.userid);

    if (context.mounted) {
      context.read<ThemeCubit>().setThemeMode(ThemeMode.light);
      context.read<UserProfileInfoCubit>().clear();
      context.read<NotificationCubit>().clear();
      context.read<ReportCubit>().clear();
    }

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }
}

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (_) => const LogoutConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
      ),
      backgroundColor: colorScheme.surface,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(ScreenUtilsManager.w20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
          color: colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.h16),
              decoration: BoxDecoration(
                color: isDark
                    ? context.palette.error.withValues(alpha: 0.15)
                    : context.palette.redLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: context.palette.red,
                size: ScreenUtilsManager.s40,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h16),

            // Title
            Text(
              S.of(context).logout,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilsManager.s20,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h12),

            // Message
            Text(
              S.of(context).logoutConfirmationMessage,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ScreenUtilsManager.h24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark
                            ? colorScheme.outline
                            : context.palette.kPrimary,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ScreenUtilsManager.r12,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilsManager.h12,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      S.of(context).cancel,
                      style: GoogleFonts.cairo(
                        color: isDark
                            ? colorScheme.onSurfaceVariant
                            : context.palette.kPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtilsManager.s14,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenUtilsManager.w12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.palette.red,
                      foregroundColor: Colors.white,
                      elevation: isDark ? 0 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ScreenUtilsManager.r12,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilsManager.h12,
                      ),
                    ),
                    child: Text(
                      S.of(context).logout,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtilsManager.s14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
