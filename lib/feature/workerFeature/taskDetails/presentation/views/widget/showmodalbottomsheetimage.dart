import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/resource/colormanager.dart';
import '../../../../../../core/service/imagepickerservice.dart';
import '../../../../../../generated/l10n.dart';

Future<List<File>?> showImageBottomSheet(BuildContext context) async {
  return await showModalBottomSheet<List<File>?>(
    barrierColor: Colors.black54,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (ctx) => Container(
      // Adding a background color and rounding the top corners
      decoration: BoxDecoration(
        color: context.palette.workerprimary, // Or your preferred dark color
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Wrap(
        children: [
          // Drag Handle for better UX
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: context.palette.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          _buildSheetButton(
            context: context,
            icon: Icons.photo_library_outlined,
            text: S.of(context).photoGallery,
            onPressed: () async {
              List<File>? images = await imagepickerMultiimage(context);
              if (ctx.mounted) Navigator.pop(ctx, images);
            },
          ),

          Divider(height: 1, color: context.palette.white.withValues(alpha: 0.1)),

          _buildSheetButton(
            context: context,
            icon: Icons.camera_alt_outlined,
            text: S.of(context).camera,
            onPressed: () async {
              File? image = await imagepickerservice(
                context,
                ImageSource.camera,
              );
              if (ctx.mounted) {
                Navigator.pop(ctx, image != null ? [image] : null);
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildSheetButton({
  required BuildContext context,
  required IconData icon,
  required String text,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(icon, color: context.palette.white, size: 24.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.cairo(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: context.palette.white,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: context.palette.white.withValues(alpha: 0.5),
            size: 14.sp,
          ),
        ],
      ),
    ),
  );
}
