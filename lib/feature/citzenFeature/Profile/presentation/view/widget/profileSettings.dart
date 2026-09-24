import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/Function/ShowCitezenaCard.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/Function/showLanguagePicker.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/Function/show_theme_picker.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/ProfileMenu.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilesettings extends StatelessWidget {
  const Profilesettings({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark
        ? context.palette.lightBlue.withValues(alpha: 0.9)
        : context.palette.lightBlue;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, isDark),
          SizedBox(height: ScreenUtilsManager.h16),
          _buildSettingsItems(context, iconColor),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isDark) {
    return Row(
      children: [
        Container(
          width: ScreenUtilsManager.w4,
          height: ScreenUtilsManager.s18,
          decoration: BoxDecoration(
            color: context.palette.lightBlue,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r4),
          ),
        ),
        SizedBox(width: ScreenUtilsManager.w8),
        Text(
          S.of(context).settings,
          style: GoogleFonts.cairo(
            letterSpacing: 1.6,
            color: isDark
                ? context.palette.onSurface.withValues(alpha: 0.8)
                : context.palette.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtilsManager.s14,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilsManager.w8,
            vertical: ScreenUtilsManager.h2,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? context.palette.outline.withValues(alpha: 0.2)
                : context.palette.lightGrey4.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
          ),
          child: Text(
            '5',
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s10,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? context.palette.onSurface.withValues(alpha: 0.6)
                  : context.palette.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItems(BuildContext context, Color iconColor) {
    final settingsItems = _getSettingsItems(context, iconColor);

    return Column(
      children: [
        for (int i = 0; i < settingsItems.length; i++) ...[
          settingsItems[i],
          if (i < settingsItems.length - 1) _buildItemDivider(context),
        ],
      ],
    );
  }

  Widget _buildItemDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h4),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: isDark
            ? context.palette.outline.withValues(alpha: 0.2)
            : context.palette.lightGrey4.withValues(alpha: 0.5),
      ),
    );
  }

  List<Widget> _getSettingsItems(BuildContext context, Color iconColor) {
    return [
      _buildMenuItem(
        context: context,
        icon: Icon(
          Icons.language,
          color: iconColor,
          size: ScreenUtilsManager.s22,
        ),
        title: S.of(context).language,
        onTap: () => showLanguagePicker(context, false),
        subtitle: _getCurrentLanguage(context),
      ),
      _buildMenuItem(
        context: context,
        icon: Icon(
          Icons.dark_mode_outlined,
          color: iconColor,
          size: ScreenUtilsManager.s22,
        ),
        title: Localizations.localeOf(context).languageCode == 'ar'
            ? 'المظهر'
            : 'Theme',
        onTap: () => showThemePicker(context),
        subtitle: _getCurrentThemeMode(context),
      ),
      _buildMenuItem(
        context: context,
        icon: Icon(
          Icons.perm_identity,
          color: iconColor,
          size: ScreenUtilsManager.s22,
        ),
        title: S.of(context).identity,
        onTap: () => showCitizenCard(context),
      ),
      _buildMenuItem(
        context: context,
        icon: Icon(
          Icons.settings,
          color: iconColor,
          size: ScreenUtilsManager.s22,
        ),
        title: S.of(context).accountInformation,
        onTap: () async {
          await Navigator.pushNamed(context, Routes.editProfile);
          if (context.mounted) {
            context.read<UserProfileInfoCubit>().getUserProfleInfo();
          }
        },
      ),
      _buildMenuItem(
        context: context,
        icon: Icon(
          Icons.list_outlined,
          color: iconColor,
          size: ScreenUtilsManager.s22,
        ),
        title: S.of(context).help,
        onTap: () => Navigator.pushNamed(context, Routes.helpSupportRoute),
        isHelp: true,
      ),
    ];
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required Widget icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    bool isHelp = false,
  }) {
    return ProfileMenuItem(iconPath: icon, title: title, onTap: onTap);
  }

  String _getCurrentLanguage(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'ar') {
      return 'العربية';
    } else if (locale.languageCode == 'en') {
      return 'English';
    }
    return locale.languageCode.toUpperCase();
  }

  String _getCurrentThemeMode(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    if (isArabic) {
      return isDark ? 'الوضع الليلي' : 'الوضع النهاري';
    }
    return isDark ? 'Dark Mode' : 'Light Mode';
  }
}

extension ProfilesettingsExtension on Profilesettings {
  static const Map<String, String> languageNames = {
    'ar': 'العربية',
    'en': 'English',
  };
}
