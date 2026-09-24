import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/citzenFeature/onbroading/controller/onbroadingprovider.dart';
import 'package:citifix/feature/citzenFeature/onbroading/widget/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Customonbroadingitem extends StatelessWidget {
  final int index;
  const Customonbroadingitem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final pageData = Constantmanger.pages[index];
    final provider = context.read<Onbroadingprovider>();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.palette.reportsPageBackground,
            context.palette.reportsPageBackground.withValues(alpha: 0.92),
            context.palette.surfaceContainerLowest,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Align(
              alignment: Alignment.centerRight,
              child: _buildSkipButton(provider),
            ),

            const Spacer(),

            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0.5, end: 1.0),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: SvgPicture.asset(
                    pageData.image,
                    height: 280.h,
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),

            const Spacer(),
            Text(
              pageData.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 26.sp,
                color: context.palette.onSurface,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                pageData.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  color: context.palette.lightGrey6.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ),
            ),
            const Spacer(flex: 2),
            _buildBottomBar(provider),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton(Onbroadingprovider provider) {
    return Selector<Onbroadingprovider, bool>(
      selector: (_, p) => p.isLastPage,
      builder: (context, isLastPage, child) {
        if (isLastPage) return SizedBox(height: 40.h);
        return InkWell(
          onTap: () => provider.controller.animateToPage(
            Constantmanger.pages.length - 1,
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: context.palette.lightGrey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              Constantmanger.skip,
              style: GoogleFonts.cairo(
                color: context.palette.kPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(Onbroadingprovider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIndicator(controller: provider.controller, count: 3),
        Selector<Onbroadingprovider, bool>(
          selector: (_, p) => p.isLastPage,
          builder: (context, isLastPage, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isLastPage ? 140.w : 60.w,
              height: 60.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.palette.kPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      isLastPage ? 15.r : 30.r,
                    ),
                  ),
                  elevation: 5,
                  shadowColor: context.palette.kPrimary.withValues(alpha: 0.4),
                ),
                onPressed: () => _handleNext(context, provider, isLastPage),
                child: isLastPage
                    ? Text(
                        Constantmanger.finish,
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Icon(Icons.arrow_forward_ios, size: 20),
              ),
            );
          },
        ),
      ],
    );
  }

  void _handleNext(
    BuildContext context,
    Onbroadingprovider provider,
    bool isLastPage,
  ) async {
    if (!isLastPage) {
      provider.controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      await PrefrenceManager().setbool(Constantmanger.isOnboardingViewed, true);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    }
  }
}
