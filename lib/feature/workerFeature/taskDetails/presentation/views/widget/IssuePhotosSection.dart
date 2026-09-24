import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/function/show_full_screen_image.dart';
import 'package:citifix/core/function/show_full_screen_video.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/onbroading/widget/indicator.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/vedioplayer.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IssuePhotosSection extends StatefulWidget {
  final List<String> mediaItems;

  const IssuePhotosSection({super.key, required this.mediaItems});

  @override
  State<IssuePhotosSection> createState() => _IssuePhotosSectionState();
}

class _IssuePhotosSectionState extends State<IssuePhotosSection> {
  final PageController _pageController = PageController();

  bool _isVideo(String path) {
    final videoExtensions = ['.mp4', '.mov', '.avi', '.mkv'];
    return videoExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).issueMedia,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s12,
            fontWeight: FontWeight.bold,
            color: context.palette.onSurfaceVariant,
            letterSpacing: ScreenUtilsManager.s1,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h12),
        Container(
          height: ScreenUtilsManager.h220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            boxShadow: [
              BoxShadow(
                color: context.palette.black.withValues(alpha: 0.05),
                blurRadius: ScreenUtilsManager.s10,
                offset: Offset(0, ScreenUtilsManager.h5),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.mediaItems.length,
                  itemBuilder: (context, index) {
                    final String item = widget.mediaItems[index];

                    if (_isVideo(item)) {
                      return AppVideoPlayer(
                        dataSource: item,
                        isRemote: true,
                        onTap:
                            () => showFullScreenVideo(
                              context,
                              item,
                              isRemote: true,
                            ),
                      );
                    }

                    return InkWell(
                      onTap: () => showFullScreenImage(context, item),
                      child: CachedNetworkImage(
                        imageUrl: item,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: context.palette.grey200,
                          child: Center(
                            child: CupertinoActivityIndicator(
                              radius: ScreenUtilsManager.r12,
                              color: context.palette.primaryColor,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.network(
                          Constantmanger.defualtImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (widget.mediaItems.length > 1)
                Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtilsManager.h12),
                  child: CustomIndicator(
                    controller: _pageController,
                    count: widget.mediaItems.length,
                    activeColor: context.palette.kPrimary,
                    dotColor: context.palette.white.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
