import 'package:citifix/core/resource/color_tokens.dart';
import 'package:flutter/material.dart';

/// Full app palette for the **current** brightness.
///
/// Light values mirror [ColorManger] (your light-theme source of truth).
/// Dark values are hand-tuned companions (same brand accents, inverted surfaces).
@immutable
class CitifixPalette extends ThemeExtension<CitifixPalette> {
  const CitifixPalette({
    required this.grey50,
    required this.black,
    required this.grey500,
    required this.grey200,
    required this.grey700,
    required this.grey600,
    required this.grey100,
    required this.notificationRedStart,
    required this.notificationRedEnd,
    required this.grey300,
    required this.primaryOpacity20,
    required this.black87,
    required this.completedButton,
    required this.black54,
    required this.grey,
    required this.kPrimary,
    required this.kPrimaryDark,
    required this.kPrimaryLight,
    required this.bgLight,
    required this.surface,
    required this.surfaceContainerLowest,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.primary,
    required this.primaryFixed,
    required this.lightGrey,
    required this.lightGrey2,
    required this.lightGrey3,
    required this.lightGrey4,
    required this.lightGrey5,
    required this.lightGrey6,
    required this.lightBlue,
    required this.red,
    required this.redLight,
    required this.tasksBackground,
    required this.green,
    required this.orange,
    required this.lightColor,
    required this.textBlack,
    required this.white,
    required this.grey400,
    required this.reportsPageBackground,
    required this.searchFieldFill,
    required this.searchIconColor,
    required this.searchHintColor,
    required this.searchFocusBorder,
    required this.primaryColor,
    required this.surfaceContainer,
    required this.bgbackground,
    required this.workerprimary,
    required this.workerbgLight,
    required this.background,
    required this.secondary,
    required this.success,
    required this.outline,
    required this.onPrimary,
    required this.error,
    required this.surfaceVariant,
    required this.surfaceLowest,
    required this.surfaceContainerHighest,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.availableContainer,
    required this.onAvailableContainer,
    required this.inProgressContainer,
    required this.onInProgressContainer,
    required this.kineticGradient,
    required this.surfaceContainerLow,
    required this.surfaceContainerHigh,
    required this.bgBackground,
    required this.textDark,
    required this.textGrey,
    required this.border,
    required this.shadow,
  });

  /// Same tokens as [ColorManger] today (light theme).
  factory CitifixPalette.light({required bool isWorker}) {
    return CitifixPalette(
      grey50: ColorManger.grey50,
      black: ColorManger.black,
      grey500: ColorManger.grey500,
      grey200: ColorManger.grey200,
      grey700: ColorManger.grey700,
      grey600: ColorManger.grey600,
      grey100: const Color(0xFFF1F5F9),
      notificationRedStart: ColorManger.notificationRedStart,
      notificationRedEnd: ColorManger.notificationRedEnd,
      grey300: ColorManger.grey300,
      primaryOpacity20: ColorManger.primaryOpacity20,
      black87: ColorManger.black87,
      completedButton: ColorManger.completedButton,
      black54: ColorManger.black54,
      grey: ColorManger.grey,
      kPrimary: ColorManger.kPrimary,
      kPrimaryDark: ColorManger.kPrimaryDark,
      kPrimaryLight: ColorManger.kPrimaryLight,
      bgLight: ColorManger.bgLight,
      surface: ColorManger.surface,
      surfaceContainerLowest: ColorManger.surfaceContainerLowest,
      onSurface: ColorManger.onSurface,
      onSurfaceVariant: ColorManger.onSurfaceVariant,
      primary: ColorManger.primary,
      primaryFixed: ColorManger.primaryFixed,
      lightGrey: ColorManger.lightGrey,
      lightGrey2: ColorManger.lightGrey2,
      lightGrey3: ColorManger.lightGrey3,
      lightGrey4: ColorManger.lightGrey4,
      lightGrey5: ColorManger.lightGrey5,
      lightGrey6: ColorManger.lightGrey6,
      lightBlue: ColorManger.lightBlue,
      red: ColorManger.red,
      redLight: ColorManger.redLight,
      tasksBackground: ColorManger.tasksBackground,
      green: ColorManger.green,
      orange: ColorManger.orange,
      lightColor: ColorManger.lightColor,
      textBlack: ColorManger.textBlack,
      white: ColorManger.white,
      grey400: ColorManger.grey400,
      reportsPageBackground: ColorManger.reportsPageBackground,
      searchFieldFill: ColorManger.searchFieldFill,
      searchIconColor: ColorManger.searchIconColor,
      searchHintColor: ColorManger.searchHintColor,
      searchFocusBorder: ColorManger.searchFocusBorder,
      primaryColor: ColorManger.primaryColor,
      surfaceContainer: ColorManger.surfaceContainer,
      bgbackground: ColorManger.bgbackground,
      workerprimary: ColorManger.workerprimary,
      workerbgLight: ColorManger.workerbgLight,
      background: ColorManger.background,
      secondary: ColorManger.secondary,
      success: ColorManger.success,
      outline: ColorManger.outline,
      onPrimary: ColorManger.onPrimary,
      error: ColorManger.error,
      surfaceVariant: ColorManger.surfaceVariant,
      surfaceLowest: ColorManger.surfaceLowest,
      surfaceContainerHighest: ColorManger.surfaceContainerHighest,
      errorContainer: ColorManger.errorContainer,
      onErrorContainer: ColorManger.onErrorContainer,
      availableContainer: ColorManger.availableContainer,
      onAvailableContainer: ColorManger.onAvailableContainer,
      inProgressContainer: ColorManger.inProgressContainer,
      onInProgressContainer: ColorManger.onInProgressContainer,
      kineticGradient: ColorManger.kineticGradient,
      surfaceContainerLow: ColorManger.surfaceContainerLow,
      surfaceContainerHigh: ColorManger.surfaceContainerHigh,
      bgBackground: ColorManger.bgBackground,
      textDark: ColorManger.textDark,
      textGrey: ColorManger.textGrey,
      border: ColorManger.border,
      shadow: Colors.black.withValues(alpha: 0.04),
    );
  }

  factory CitifixPalette.dark({
    bool workerAccent = false,
    required bool isWorker,
  }) {
    const Color scaffold = Color(0xFF0F172A);
    const Color surface = Color(0xFF1B2634);
    const Color surfaceContainerLow = Color(0xFF151F2E);
    const Color surfaceHigh = Color(0xFF273549);
    const Color surfaceHighest = Color(0xFF324458);
    // Primary / secondary text: brighter than typical “slate on navy” defaults for readability.
    const Color onSurf = Color(0xFFF8FAFC);
    const Color onVar = Color(0xFFE2E8F0);
    const Color onTertiary = Color(0xFFCBD5E1);
    const Color primaryBlueOnDark = Color(0xFF9EC5FF);
    const Color primaryWorkerOnDark = Color(0xFFFFB74D);
    final Color primaryOnDark = workerAccent
        ? primaryWorkerOnDark
        : primaryBlueOnDark;
    const Color borderDark = Color(0xFF3D4F66);
    const Color outlineDark = Color(0xFF5A6D85);
    final Color onPrimaryDark = workerAccent
        ? const Color(0xFF271800)
        : scaffold;
    final Color primaryFixedDark = workerAccent
        ? const Color(0xFF5C3D14)
        : const Color(0xFF1E3A5F);

    return CitifixPalette(
      grey50: Color(0xFF1E293B),
      black: onSurf,
      grey500: onTertiary,
      grey200: borderDark,
      grey700: Color(0xFFE2E8F0),
      grey600: onVar,
      grey100: const Color(0xFF1E293B),
      notificationRedStart: Color(0xFFFF6B6B),
      notificationRedEnd: Color(0xFFFF5252),
      grey300: outlineDark,
      primaryOpacity20: ColorManger.workerprimary.withValues(alpha: 0.2),
      black87: onSurf,
      completedButton: ColorManger.completedButton,
      black54: onTertiary,
      grey: outlineDark,
      kPrimary: primaryOnDark,
      kPrimaryDark: scaffold,
      kPrimaryLight: workerAccent
          ? const Color(0xFFFFCC80)
          : const Color(0xFF5B8FD9),
      bgLight: surface,
      surface: surface,
      surfaceContainerLowest: surfaceHigh,
      onSurface: onSurf,
      onSurfaceVariant: onVar,
      primary: primaryOnDark,
      primaryFixed: primaryFixedDark,
      lightGrey: onVar,
      lightGrey2: onTertiary,
      lightGrey3: Color(0xFF94A3B8),
      lightGrey4: surfaceHigh,
      lightGrey5: surface,
      lightGrey6: onVar,
      lightBlue: Color(0xFF7EB3FF),
      red: Color(0xFFFF8A80),
      redLight: Color(0xFF3F1E1E),
      tasksBackground: surface,
      green: Color(0xFF4ADE80),
      orange: Color(0xFFFBBF24),
      lightColor: primaryOnDark,
      textBlack: onSurf,
      white: surfaceHigh,
      grey400: onTertiary,
      reportsPageBackground: scaffold,
      searchFieldFill: surfaceHigh,
      searchIconColor: onVar,
      searchHintColor: onTertiary,
      searchFocusBorder: outlineDark,
      primaryColor: ColorManger.primaryColor,
      surfaceContainer: borderDark,
      bgbackground: scaffold,
      workerprimary: ColorManger.workerprimary,
      workerbgLight: surface,
      background: scaffold,
      secondary: onTertiary,
      success: Color(0xFF4ADE80),
      outline: outlineDark,
      onPrimary: onPrimaryDark,
      error: Color(0xFFFF8A80),
      surfaceVariant: borderDark,
      surfaceLowest: surfaceHigh,
      surfaceContainerHighest: surfaceHighest,
      errorContainer: Color(0xFF5C2B2B),
      onErrorContainer: Color(0xFFFFDAD6),
      availableContainer: Color(0xFF5C4A1F),
      onAvailableContainer: Color(0xFFFFE08A),
      inProgressContainer: ColorManger.inProgressContainer,
      onInProgressContainer: Color(0xFFFFE0CC),
      kineticGradient: LinearGradient(
        colors: workerAccent
            ? const [Color(0xFFFFB74D), Color(0xFFFFE0B2)]
            : const [Color(0xFF8DB9F5), Color(0xFFD7E2FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainerHigh: surfaceHigh,
      bgBackground: scaffold,
      textDark: onSurf,
      textGrey: onTertiary,
      border: borderDark,
      shadow: Colors.black.withValues(alpha: 0.3),
    );
  }

  final Color grey50;
  final Color black;
  final Color grey500;
  final Color grey200;
  final Color grey700;
  final Color grey600;
  final Color grey100;
  final Color notificationRedStart;
  final Color notificationRedEnd;
  final Color grey300;
  final Color primaryOpacity20;
  final Color black87;
  final Color completedButton;
  final Color black54;
  final Color grey;
  final Color kPrimary;
  final Color kPrimaryDark;
  final Color kPrimaryLight;
  final Color bgLight;
  final Color surface;
  final Color surfaceContainerLowest;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color primary;
  final Color primaryFixed;
  final Color lightGrey;
  final Color lightGrey2;
  final Color lightGrey3;
  final Color lightGrey4;
  final Color lightGrey5;
  final Color lightGrey6;
  final Color lightBlue;
  final Color red;
  final Color redLight;
  final Color tasksBackground;
  final Color green;
  final Color orange;
  final Color lightColor;
  final Color textBlack;
  final Color white;
  final Color grey400;
  final Color reportsPageBackground;
  final Color searchFieldFill;
  final Color searchIconColor;
  final Color searchHintColor;
  final Color searchFocusBorder;
  final Color primaryColor;
  final Color surfaceContainer;
  final Color bgbackground;
  final Color workerprimary;
  final Color workerbgLight;
  final Color background;
  final Color secondary;
  final Color success;
  final Color outline;
  final Color onPrimary;
  final Color error;
  final Color surfaceVariant;
  final Color surfaceLowest;
  final Color surfaceContainerHighest;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color availableContainer;
  final Color onAvailableContainer;
  final Color inProgressContainer;
  final Color onInProgressContainer;
  final LinearGradient kineticGradient;
  final Color surfaceContainerLow;
  final Color surfaceContainerHigh;
  final Color bgBackground;
  final Color textDark;
  final Color textGrey;
  final Color border;
  final Color shadow;

  @override
  CitifixPalette copyWith({
    Color? grey50,
    Color? black,
    Color? grey500,
    Color? grey200,
    Color? grey700,
    Color? grey600,
    Color? grey100,
    Color? notificationRedStart,
    Color? notificationRedEnd,
    Color? grey300,
    Color? primaryOpacity20,
    Color? black87,
    Color? completedButton,
    Color? black54,
    Color? grey,
    Color? kPrimary,
    Color? kPrimaryDark,
    Color? kPrimaryLight,
    Color? bgLight,
    Color? surface,
    Color? surfaceContainerLowest,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? primary,
    Color? primaryFixed,
    Color? lightGrey,
    Color? lightGrey2,
    Color? lightGrey3,
    Color? lightGrey4,
    Color? lightGrey5,
    Color? lightGrey6,
    Color? lightBlue,
    Color? red,
    Color? redLight,
    Color? tasksBackground,
    Color? green,
    Color? orange,
    Color? lightColor,
    Color? textBlack,
    Color? white,
    Color? grey400,
    Color? reportsPageBackground,
    Color? searchFieldFill,
    Color? searchIconColor,
    Color? searchHintColor,
    Color? searchFocusBorder,
    Color? primaryColor,
    Color? surfaceContainer,
    Color? bgbackground,
    Color? workerprimary,
    Color? workerbgLight,
    Color? background,
    Color? secondary,
    Color? success,
    Color? outline,
    Color? onPrimary,
    Color? error,
    Color? surfaceVariant,
    Color? surfaceLowest,
    Color? surfaceContainerHighest,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? availableContainer,
    Color? onAvailableContainer,
    Color? inProgressContainer,
    Color? onInProgressContainer,
    LinearGradient? kineticGradient,
    Color? surfaceContainerLow,
    Color? surfaceContainerHigh,
    Color? bgBackground,
    Color? textDark,
    Color? textGrey,
    Color? border,
    Color? shadow,
  }) {
    return CitifixPalette(
      grey50: grey50 ?? this.grey50,
      black: black ?? this.black,
      grey500: grey500 ?? this.grey500,
      grey200: grey200 ?? this.grey200,
      grey700: grey700 ?? this.grey700,
      grey600: grey600 ?? this.grey600,
      grey100: grey100 ?? this.grey100,
      notificationRedStart: notificationRedStart ?? this.notificationRedStart,
      notificationRedEnd: notificationRedEnd ?? this.notificationRedEnd,
      grey300: grey300 ?? this.grey300,
      primaryOpacity20: primaryOpacity20 ?? this.primaryOpacity20,
      black87: black87 ?? this.black87,
      completedButton: completedButton ?? this.completedButton,
      black54: black54 ?? this.black54,
      grey: grey ?? this.grey,
      kPrimary: kPrimary ?? this.kPrimary,
      kPrimaryDark: kPrimaryDark ?? this.kPrimaryDark,
      kPrimaryLight: kPrimaryLight ?? this.kPrimaryLight,
      bgLight: bgLight ?? this.bgLight,
      surface: surface ?? this.surface,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      primary: primary ?? this.primary,
      primaryFixed: primaryFixed ?? this.primaryFixed,
      lightGrey: lightGrey ?? this.lightGrey,
      lightGrey2: lightGrey2 ?? this.lightGrey2,
      lightGrey3: lightGrey3 ?? this.lightGrey3,
      lightGrey4: lightGrey4 ?? this.lightGrey4,
      lightGrey5: lightGrey5 ?? this.lightGrey5,
      lightGrey6: lightGrey6 ?? this.lightGrey6,
      lightBlue: lightBlue ?? this.lightBlue,
      red: red ?? this.red,
      redLight: redLight ?? this.redLight,
      tasksBackground: tasksBackground ?? this.tasksBackground,
      green: green ?? this.green,
      orange: orange ?? this.orange,
      lightColor: lightColor ?? this.lightColor,
      textBlack: textBlack ?? this.textBlack,
      white: white ?? this.white,
      grey400: grey400 ?? this.grey400,
      reportsPageBackground:
          reportsPageBackground ?? this.reportsPageBackground,
      searchFieldFill: searchFieldFill ?? this.searchFieldFill,
      searchIconColor: searchIconColor ?? this.searchIconColor,
      searchHintColor: searchHintColor ?? this.searchHintColor,
      searchFocusBorder: searchFocusBorder ?? this.searchFocusBorder,
      primaryColor: primaryColor ?? this.primaryColor,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      bgbackground: bgbackground ?? this.bgbackground,
      workerprimary: workerprimary ?? this.workerprimary,
      workerbgLight: workerbgLight ?? this.workerbgLight,
      background: background ?? this.background,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      outline: outline ?? this.outline,
      onPrimary: onPrimary ?? this.onPrimary,
      error: error ?? this.error,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      surfaceLowest: surfaceLowest ?? this.surfaceLowest,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      availableContainer: availableContainer ?? this.availableContainer,
      onAvailableContainer: onAvailableContainer ?? this.onAvailableContainer,
      inProgressContainer: inProgressContainer ?? this.inProgressContainer,
      onInProgressContainer:
          onInProgressContainer ?? this.onInProgressContainer,
      kineticGradient: kineticGradient ?? this.kineticGradient,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      bgBackground: bgBackground ?? this.bgBackground,
      textDark: textDark ?? this.textDark,
      textGrey: textGrey ?? this.textGrey,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ThemeExtension<CitifixPalette> lerp(
    ThemeExtension<CitifixPalette>? other,
    double t,
  ) {
    if (other is! CitifixPalette) return this;
    if (t < 0.5) return this;
    return other;
  }
}

extension CitifixPaletteX on BuildContext {
  CitifixPalette get palette {
    final CitifixPalette? p = Theme.of(this).extension<CitifixPalette>();
    assert(p != null, 'Register CitifixPalette in ThemeData.extensions');
    return p!;
  }
}
