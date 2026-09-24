import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/commentmodel/commentmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentBubble extends StatelessWidget {
  final CommentModel comment;
  const CommentBubble({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final bool isWorker = comment.userRole == UserType.worker;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bubbleColor = isWorker
        ? context.palette.workerprimary
        : (isDark
              ? context.palette.surfaceContainerHigh
              : context.palette.grey100);

    final textColor = isWorker ? Colors.white : context.palette.onSurface;

    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilsManager.h16),
      child: Column(
        crossAxisAlignment: isWorker
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isWorker
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!isWorker) ...[
                _buildAvatar(
                  comment.userProfileImageUrl,
                  context.palette.kPrimary,
                ),
                SizedBox(width: ScreenUtilsManager.w8),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: isWorker
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.w14,
                        vertical: ScreenUtilsManager.h10,
                      ),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(ScreenUtilsManager.r16),
                          topEnd: Radius.circular(ScreenUtilsManager.r16),
                          bottomStart: Radius.circular(
                            isWorker ? ScreenUtilsManager.r16 : 0,
                          ),
                          bottomEnd: Radius.circular(
                            isWorker ? 0 : ScreenUtilsManager.r16,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        comment.commentText,
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s14,
                          color: textColor,
                          height: 1.5,
                          fontWeight: isWorker
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilsManager.h4),
                    _buildTime(context),
                  ],
                ),
              ),
              if (isWorker) ...[
                SizedBox(width: ScreenUtilsManager.w8),
                _buildAvatar(
                  comment.userProfileImageUrl,
                  context.palette.workerprimary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTime(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w4),
      child: Text(
        comment.createdAt.timeAgo(context),
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s10,
          color: context.palette.onSurfaceVariant.withValues(alpha: 0.5),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildAvatar(String url, Color color) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: ScreenUtilsManager.r14,
          backgroundColor: color.withValues(alpha: 0.1),
          child: ClipOval(
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  const CupertinoActivityIndicator(radius: 6),
              errorWidget: (c, e, s) =>
                  Icon(Icons.person, size: 14, color: color),
              imageUrl: url,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
