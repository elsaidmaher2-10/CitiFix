import 'package:flutter/material.dart';

/// Light-theme color tokens (source of truth). For UI, prefer [CitifixPalette] via
/// `context.palette` so dark mode matches these semantics.
class ColorManger {
  static Color get grey50 => Colors.grey.shade50;
  static const Color black = Colors.black;
  static Color get grey500 => Colors.grey.shade500;
  static Color get grey200 => Colors.grey.shade200;
  static Color get grey700 => Colors.grey.shade700;
  static Color get grey600 => Colors.grey.shade600;
  static const Color notificationRedStart = Color(0xffFF5252);
  static const Color notificationRedEnd = Color(0xffFF1744);
  static Color get grey300 => Colors.grey.shade300;
  static Color get primaryOpacity20 =>
      ColorManger.workerprimary.withValues(alpha: 0.2);
  static const Color black87 = Colors.black87;
  static const Color completedButton = Color(0xFFFF8A00);
  static const Color black54 = Colors.black54;
  static const Color grey = Colors.grey;
  static const Color kPrimary = Color(0xff003366);
  static const Color kPrimaryDark = Color(0xff0F172A);
  static const Color kPrimaryLight = Color.fromARGB(204, 112, 167, 222);
  static const Color bgLight = Color(0xFFF8F6F6);
  static const surface = Color(0xFFF7F9FB);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF191C1E);
  static const onSurfaceVariant = Color(0xFF424751);
  static const primary = Color(0xFF00346F);
  static const primaryFixed = Color(0xFFD7E2FF);
  static const Color lightGrey = Color(0xff505050);
  static const Color lightGrey2 = Color(0xff828282);
  static const Color lightGrey3 = Color(0xff6C6C6C);
  static const Color lightGrey4 = Color(0xffF4F2F2);
  static const Color lightGrey5 = Color(0xffF1F5F9);
  static const Color lightGrey6 = Color(0xff64748B);
  static const Color lightBlue = Color(0xff1162D4);
  static const Color red = Color(0xffFC1B1A);
  static const Color redLight = Color(0xffFEE2E2);
  static const Color tasksBackground = Color(0xFFF8F9FB);

  static const Color green = Color(0xff08A43A);
  static const Color orange = Color(0xffF59E0B);
  static const Color lightColor = Color(0xff2A4D8B);
  static const Color textBlack = Color(0xff111827);
  static const Color white = Color(0xffFFFFFF);
  static Color get grey400 => Colors.grey.shade400;
  static const Color reportsPageBackground = Color(0xFFF6F7F8);
  static const Color searchFieldFill = Color(0xffF1F5F9);
  static const Color searchIconColor = Color(0xff475569);
  static const Color searchHintColor = Color(0xff94A3B8);
  static const Color searchFocusBorder = Color(0xff475569);
  static final Color primaryColor = const Color(0xFFFF7B04);
  static final Color surfaceContainer = const Color(0xFFE7E8E8);
  static final Color bgbackground = const Color(0xFFF6F6F6);
  static const Color workerprimary = Color(0xFFFF7B00);
  static const Color workerbgLight = Color(0xFFF8F7F5);

  static const background = Color(0xFFFFFFFF);

  static const secondary = Color(0xFF777777);

  static const success = Color(0xFF34C759);

  static const outline = Color(0xFFDDDDDD);

  static const onPrimary = Color(0xFFFFFFFF);

  static const error = Color(0xFFFF3B30);

  static const surfaceVariant = Color(0xFFE0E0E0);

  static const Color surfaceLowest = Color(0xFFFFFFFF);

  static const Color surfaceContainerHighest = Color(0xFFDBDDDD);

  static const Color errorContainer = Color(0xFFF95630);

  static const Color onErrorContainer = Color(0xFF520C00);

  static const Color availableContainer = Color(0xFFF9BD26);

  static const Color onAvailableContainer = Color(0xFF543C00);

  static const Color inProgressContainer = Color(0xFFFF7B04);

  static const Color onInProgressContainer = Color(0xFF3D1800);

  static const LinearGradient kineticGradient = LinearGradient(
    colors: [primary, primaryFixed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const surfaceContainerLow = Color(0xFFF5F5F5);
  static const surfaceContainerHigh = Color(0xFFF5F5F5);
  static const Color bgBackground = Color(0xFFF7F7F7);
  static const Color textDark = Color(0xFF222222);
  static const Color textGrey = Color(0xFF777777);
  static const Color border = Color(0xFFE0E0E0);
}
