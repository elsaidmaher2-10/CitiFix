import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resource/colormanager.dart';


import '../../../core/resource/screenutilsmaanger.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.isvrified,
  });

  final String name;
  final bool isvrified;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: ScreenUtilsManager.h80,
        bottom: ScreenUtilsManager.h40,
      ),
      child: Column(
        children: [
          _Avatar(avatarUrl: avatarUrl, isvrified: isvrified),
          SizedBox(height: ScreenUtilsManager.h24),
          Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w800,
              fontSize: ScreenUtilsManager.s26,
              color: context.palette.onSurface,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h4),
          Text(
            Localizations.localeOf(context).languageCode == 'ar'
                ? "دائماً في خدمتك لتحسين مدينتنا"
                : "Always at your service to improve our city",
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              fontWeight: FontWeight.w500,
              color: context.palette.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          if (isvrified)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: context.palette.workerprimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: context.palette.workerprimary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified,
                    color: context.palette.workerprimary,
                    size: ScreenUtilsManager.s16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? 'خبير موثق'
                        : 'Verified Expert',
                    style: GoogleFonts.cairo(
                      color: context.palette.workerprimary,
                      fontSize: ScreenUtilsManager.s12,
                      fontWeight: FontWeight.w700,
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl, required this.isvrified});

  final String avatarUrl;
  final bool isvrified;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.palette.orange, width: 3),
              color: Colors.white,
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                color: context.palette.surfaceContainer,
                image: DecorationImage(
                  image: NetworkImage(avatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (isvrified)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.palette.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.palette.surface, width: 2),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
            ),
        ],
      ),
    );
  }
}
