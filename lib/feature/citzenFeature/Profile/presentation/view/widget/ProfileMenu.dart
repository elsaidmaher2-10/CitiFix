import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuItem extends StatelessWidget {
  final Widget iconPath;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDestructive
        ? context.palette.error
        : context.palette.onSurface;
    final subtitleColor = context.palette.onSurfaceVariant;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
            border: Border.all(
              color: isDark
                  ? context.palette.outline.withValues(alpha: 0.3)
                  : context.palette.lightGrey4,
              width: isDark ? 0.5.w : 1.w,
            ),
          ),
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
            elevation: 0,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
              highlightColor: isDestructive
                  ? context.palette.error.withValues(alpha: 0.1)
                  : (isDark
                        ? context.palette.lightBlue.withValues(alpha: 0.1)
                        : Colors.transparent),
              splashColor: isDestructive
                  ? context.palette.error.withValues(alpha: 0.05)
                  : (isDark
                        ? context.palette.lightBlue.withValues(alpha: 0.05)
                        : Colors.transparent),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w16,
                  vertical: ScreenUtilsManager.h12,
                ),
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: ScreenUtilsManager.w44,
                      height: ScreenUtilsManager.w44,
                      decoration: BoxDecoration(
                        color: isDark
                            ? (isDestructive
                                  ? context.palette.error.withValues(
                                      alpha: 0.12,
                                    )
                                  : context.palette.lightBlue.withValues(
                                      alpha: 0.12,
                                    ))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          ScreenUtilsManager.r12,
                        ),
                      ),
                      child: Center(child: iconPath),
                    ),
                    SizedBox(width: ScreenUtilsManager.w16),

                    // Title and Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.cairo(
                              fontSize: ScreenUtilsManager.s15,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                          if (subtitle != null) ...[
                            SizedBox(height: ScreenUtilsManager.h4),
                            Text(
                              subtitle!,
                              style: GoogleFonts.cairo(
                                fontSize: ScreenUtilsManager.s12,
                                color: subtitleColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Trailing Arrow
                    Container(
                      width: ScreenUtilsManager.w32,
                      height: ScreenUtilsManager.w32,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          ScreenUtilsManager.r8,
                        ),
                      ),
                      child: RotatedBox(
                        quarterTurns: 90,
                        child: Icon(
                          CupertinoIcons.back,
                          color: context.palette.onSurfaceVariant.withValues(
                            alpha: 0.6,
                          ),
                          size: ScreenUtilsManager.s16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (!isDestructive) SizedBox(height: ScreenUtilsManager.h10),
      ],
    );
  }
}
