import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static Color _accentForRole(AppRole role) =>
      role == AppRole.worker ? ColorManger.workerprimary : ColorManger.kPrimary;

  static ThemeData light(AppRole role) {
    final Color accent = _accentForRole(role);
    final bool isWorker = role == AppRole.worker;
    final ColorScheme scheme = ColorScheme.light(
      primary: ColorManger.kPrimary,
      onPrimary: ColorManger.onPrimary,
      primaryContainer: ColorManger.primaryFixed,
      onPrimaryContainer: ColorManger.primary,
      secondary: ColorManger.lightGrey6,
      onSecondary: ColorManger.white,
      surface: ColorManger.surfaceLowest,
      onSurface: ColorManger.onSurface,
      onSurfaceVariant: ColorManger.onSurfaceVariant,
      error: ColorManger.error,
      onError: ColorManger.white,
      outline: ColorManger.outline,
      surfaceContainerHighest: ColorManger.surfaceContainer,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      extensions: <ThemeExtension<dynamic>>[
        CitifixPalette.light(isWorker: isWorker),
      ],
      colorScheme: scheme,
      scaffoldBackgroundColor: ColorManger.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: DividerThemeData(
        color: ColorManger.border.withValues(alpha: 0.6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManger.kPrimary,
          foregroundColor: ColorManger.white,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: accent,
        selectionColor: accent.withValues(alpha: 0.35),
        cursorColor: ColorManger.kPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorManger.searchFieldFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorManger.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorManger.outline),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorManger.kPrimary.withValues(alpha: 0.55);
          }
          return ColorManger.outline.withValues(alpha: 0.5);
        }),
      ),
    );
  }

  /// Dark surfaces from navy [ColorManger.kPrimaryDark] / [ColorManger.primary],
  /// with a lighter primary for contrast on dark backgrounds.
  static ThemeData dark(AppRole role) {
    final Color accent = _accentForRole(role);
    const Color scaffold = Color(0xFF0F172A);
    const Color surface = Color(0xFF1B2634);
    const Color surfaceContainerLow = Color(0xFF151F2E);
    const Color surfaceHigh = Color(0xFF273549);
    const Color surfaceHighest = Color(0xFF324458);
    const Color onSurfaceMain = Color(0xFFF8FAFC);
    const Color onSurfaceMuted = Color(0xFFE2E8F0);
    const Color outlineMuted = Color(0xFF3D4F66);

    final bool isWorker = role == AppRole.worker;
    final Color primaryOnDark = isWorker
        ? const Color(0xFFFFB74D)
        : const Color(0xFF9EC5FF);
    final Color onPrimaryDark = isWorker
        ? const Color(0xFF271800)
        : ColorManger.kPrimaryDark;
    final Color primaryContainerDark = isWorker
        ? const Color(0xFF5C3D14)
        : const Color(0xFF1E3A5F);
    final Color onPrimaryContainerDark = isWorker
        ? const Color(0xFFFFE0B2)
        : ColorManger.primaryFixed;

    final ColorScheme scheme = ColorScheme.dark(
      primary: primaryOnDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryContainerDark,
      onPrimaryContainer: onPrimaryContainerDark,
      secondary: const Color(0xFF94A3B8),
      onSecondary: scaffold,
      tertiary: const Color(0xFF7EB3FF),
      onTertiary: scaffold,
      surface: surface,
      onSurface: onSurfaceMain,
      onSurfaceVariant: onSurfaceMuted,
      error: const Color(0xFFFF8A80),
      onError: scaffold,
      errorContainer: const Color(0xFF5C2B2B),
      onErrorContainer: const Color(0xFFFFDAD6),
      outline: const Color(0xFF5A6D85),
      outlineVariant: outlineMuted,
      shadow: Colors.black,
      scrim: Color(0xCC000000),
      surfaceContainerLowest: scaffold,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surface,
      surfaceContainerHigh: surfaceHigh,
      surfaceContainerHighest: surfaceHighest,
      inverseSurface: onSurfaceMain,
      onInverseSurface: scaffold,
      inversePrimary: isWorker ? const Color(0xFFE65100) : ColorManger.kPrimary,
    );

    final TextTheme darkTextBase = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    ).textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      extensions: <ThemeExtension<dynamic>>[
        CitifixPalette.dark(isWorker: isWorker, workerAccent: isWorker),
      ],
      colorScheme: scheme,
      textTheme: darkTextBase.copyWith(
        displayLarge: darkTextBase.displayLarge?.copyWith(color: onSurfaceMain),
        displayMedium: darkTextBase.displayMedium?.copyWith(
          color: onSurfaceMain,
        ),
        displaySmall: darkTextBase.displaySmall?.copyWith(color: onSurfaceMain),
        headlineLarge: darkTextBase.headlineLarge?.copyWith(
          color: onSurfaceMain,
        ),
        headlineMedium: darkTextBase.headlineMedium?.copyWith(
          color: onSurfaceMain,
        ),
        headlineSmall: darkTextBase.headlineSmall?.copyWith(
          color: onSurfaceMain,
        ),
        titleLarge: darkTextBase.titleLarge?.copyWith(color: onSurfaceMain),
        titleMedium: darkTextBase.titleMedium?.copyWith(color: onSurfaceMain),
        titleSmall: darkTextBase.titleSmall?.copyWith(color: onSurfaceMain),
        bodyLarge: darkTextBase.bodyLarge?.copyWith(
          color: onSurfaceMain,
          height: 1.4,
        ),
        bodyMedium: darkTextBase.bodyMedium?.copyWith(
          color: onSurfaceMain,
          height: 1.4,
        ),
        bodySmall: darkTextBase.bodySmall?.copyWith(color: onSurfaceMuted),
        labelLarge: darkTextBase.labelLarge?.copyWith(color: onSurfaceMain),
        labelMedium: darkTextBase.labelMedium?.copyWith(color: onSurfaceMuted),
        labelSmall: darkTextBase.labelSmall?.copyWith(color: onSurfaceMuted),
      ),
      scaffoldBackgroundColor: scaffold,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: scheme.surfaceContainer,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: scheme.onSurface),
        actionsIconTheme: IconThemeData(color: scheme.onSurface),
      ),
      iconTheme: IconThemeData(color: onSurfaceMuted),
      primaryIconTheme: IconThemeData(color: primaryOnDark),
      cardTheme: CardThemeData(
        color: surfaceHigh,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: outlineMuted.withValues(alpha: 0.55)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: outlineMuted.withValues(alpha: 0.65),
        thickness: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOnDark,
          foregroundColor: onPrimaryDark,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryOnDark,
          foregroundColor: onPrimaryDark,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryOnDark,
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.9)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryOnDark),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: accent,
        selectionColor: accent.withValues(alpha: 0.45),
        cursorColor: primaryOnDark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryOnDark,
        foregroundColor: onPrimaryDark,
        elevation: 2,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceHigh,
        selectedColor: primaryOnDark.withValues(alpha: 0.22),
        disabledColor: surfaceContainerLow,
        labelStyle: TextStyle(color: onSurfaceMain, fontSize: 13),
        secondaryLabelStyle: TextStyle(color: onSurfaceMuted, fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: outlineMuted.withValues(alpha: 0.6)),
        brightness: Brightness.dark,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: onSurfaceMuted,
        textColor: onSurfaceMain,
        titleTextStyle: TextStyle(
          color: onSurfaceMain,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: TextStyle(color: onSurfaceMuted, fontSize: 14),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceHigh,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: surfaceHigh,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        dragHandleColor: onSurfaceMuted.withValues(alpha: 0.45),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceHigh,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: TextStyle(
          color: onSurfaceMain,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(color: onSurfaceMuted, fontSize: 15),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: primaryOnDark.withValues(alpha: 0.22),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final Color c = states.contains(WidgetState.selected)
              ? primaryOnDark
              : onSurfaceMuted;
          return TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: c);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final Color c = states.contains(WidgetState.selected)
              ? primaryOnDark
              : onSurfaceMuted;
          return IconThemeData(color: c);
        }),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        selectedItemColor: primaryOnDark,
        unselectedItemColor: onSurfaceMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceHighest,
        contentTextStyle: TextStyle(color: onSurfaceMain),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceHigh,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.45)),
        ),
        textStyle: TextStyle(color: onSurfaceMain, fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryOnDark,
        linearTrackColor: primaryOnDark.withValues(alpha: 0.22),
        circularTrackColor: primaryOnDark.withValues(alpha: 0.22),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOnDark.withValues(alpha: 0.55);
          }
          return outlineMuted.withValues(alpha: 0.5);
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primaryOnDark;
          if (states.contains(WidgetState.disabled)) {
            return outlineMuted.withValues(alpha: 0.35);
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.resolveWith((_) => onPrimaryDark),
        side: BorderSide(color: scheme.outline, width: 1.5),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primaryOnDark;
          return onSurfaceMuted;
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceHigh,
        labelStyle: TextStyle(color: onSurfaceMuted),
        hintStyle: TextStyle(color: onSurfaceMuted.withValues(alpha: 0.85)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.85)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.85)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryOnDark, width: 1.75),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.error.withValues(alpha: 0.95)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.error, width: 1.75),
        ),
      ),
    );
  }
}
