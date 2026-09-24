import 'dart:io';
import 'package:citifix/core/function/show_full_screen_video.dart';
import 'package:citifix/core/widget/uploadimage.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/extensionvediotype.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/vedioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerList extends StatelessWidget {
  final void Function()? onAddImage;
  final List<File>? images;
  final Stream<List<File>> stream;
  final void Function(int index) onRemove;

  const ImagePickerList({
    super.key,
    required this.onAddImage,
    required this.images,
    required this.stream,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105.h,
      child: Row(
        children: [
          Uploadimage(onTap: onAddImage),
          SizedBox(width: 8.w),
          Expanded(
            child: StreamBuilder<List<File>>(
              initialData: images ?? [],
              stream: stream,
              builder: (context, snapshot) => ListView.separated(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.length ?? 0,
                separatorBuilder: (_, _) => SizedBox(width: 8.w),
                itemBuilder: (ctx, index) {
                  final image = snapshot.data![index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: image.isVideo
                                  ? AppVideoPlayer(
                                    dataSource: image.path,
                                    isRemote: false,
                                    onTap:
                                        () => showFullScreenVideo(
                                          context,
                                          image.path,
                                          isRemote: false,
                                        ),
                                  )
                                  : GestureDetector(
                                    onTap: () {}, // Images don't have full screen preview here currently, but we could add it
                                    child: Image.file(image, fit: BoxFit.cover),
                                  ),
                            ),
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              end: 4.w,
                              top: 4.h,
                              child: InkWell(
                                onTap: () => onRemove(index),
                                child: CircleAvatar(
                                  radius: 12.r,
                                  backgroundColor: Colors.black.withValues(
                                    alpha: 0.5,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
