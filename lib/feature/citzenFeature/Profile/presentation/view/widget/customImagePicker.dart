import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/core/cubit/controller/imageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Customimagepicker extends StatelessWidget {
  Customimagepicker({
    super.key,
    required this.role,
    required this.userProfile,
    this.imagePickerController,
  });

  final bool role;
  final UserProfile? userProfile;
  final ImagePickerController? imagePickerController;

  Future<void> _pickImage(
    BuildContext context,
    ImagePickerController controller,
  ) async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.palette.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.all(ScreenUtilsManager.h24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.palette.outline.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            Text(
              Localizations.localeOf(context).languageCode == 'ar'
                  ? 'اختر مصدر الصورة'
                  : 'Choose Image Source',
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s18,
                fontWeight: FontWeight.w800,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            Row(
              children: [
                _SourceOption(
                  icon: Icons.camera_alt_rounded,
                  label: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'الكاميرا'
                      : 'Camera',
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                  color: role
                      ? context.palette.workerprimary
                      : context.palette.primary,
                ),
                SizedBox(width: ScreenUtilsManager.w16),
                _SourceOption(
                  icon: Icons.photo_library_rounded,
                  label: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'المعرض'
                      : 'Gallery',
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                  color: role
                      ? context.palette.workerprimary
                      : context.palette.primary,
                ),
              ],
            ),
            SizedBox(height: ScreenUtilsManager.h16),
          ],
        ),
      ),
    );

    if (source != null) {
      final File? image = await controller.pickImage(source);
      if (image != null && context.mounted) {
        if (image.lengthSync() > 10 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? 'حجم الصورة كبير جداً (الحد الأقصى 10 ميجابايت)'
                    : 'Image size is too large (Max 10MB)',
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        await context.read<UserProfileInfoCubit>().updateUserProfleImage(image);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = imagePickerController ?? ImagePickerController();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        StreamBuilder<File?>(
          stream: controller.stream,
          builder: (context, snapshot) {
            final pickedFile = snapshot.data;
            final isImageLoading = controller.isLoading;

            ImageProvider imageProvider;
            if (pickedFile != null) {
              imageProvider = FileImage(pickedFile);
            } else if (userProfile?.profileImage != null &&
                userProfile!.profileImage!.isNotEmpty) {
              imageProvider = userProfile!.profileImage!.startsWith('http')
                  ? CachedNetworkImageProvider(userProfile!.profileImage!)
                  : FileImage(File(userProfile!.profileImage!));
            } else {
              imageProvider = AssetImage(AssetValueManager.defualtimage);
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(context, controller),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: role
                          ? LinearGradient(
                            colors: [
                              context.palette.workerprimary,
                              context.palette.orange,
                            ],
                          )
                          : context.palette.kineticGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: context.palette.surface,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: ScreenUtilsManager.r64,
                        backgroundColor: context.palette.surfaceContainer,
                        backgroundImage: imageProvider,
                        onBackgroundImageError: (_, _) {},
                      ),
                    ),
                  ),
                ),
                if (isImageLoading)
                  Container(
                    width: (ScreenUtilsManager.r64 * 2) + 8,
                    height: (ScreenUtilsManager.r64 * 2) + 8,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SpinKitPouringHourGlassRefined(
                        color: Colors.white,
                        size: ScreenUtilsManager.h40,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _pickImage(context, controller),
                    child: Container(
                      padding: EdgeInsets.all(ScreenUtilsManager.h8),
                      decoration: BoxDecoration(
                        color: role
                            ? context.palette.workerprimary
                            : context.palette.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.palette.surface,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: ScreenUtilsManager.s20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SourceOption extends StatelessWidget {
  const _SourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.palette.outline.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenUtilsManager.h12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: ScreenUtilsManager.s28),
                ),
                SizedBox(height: ScreenUtilsManager.h12),
                Text(
                  label,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s14,
                    fontWeight: FontWeight.w700,
                    color: context.palette.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
