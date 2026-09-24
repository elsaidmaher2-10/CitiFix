import 'dart:async';
import 'dart:io';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/showmodalbottomsheetimage.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/workerimagePicker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/resource/colormanager.dart';
import '../../../../../../core/resource/screenutilsmaanger.dart';
import '../../../../../../generated/l10n.dart'; // تم إضافة ملف الترجمة

class CompletionDataSection extends StatefulWidget {
  const CompletionDataSection({
    super.key,
    required this.onFilesChanged,
    required this.streamController,
    required this.notesController,
    required this.addimage,
    required this.removeImage,
  });

  final StreamController<List<File>> streamController;
  final Function(List<File>) onFilesChanged;
  final TextEditingController notesController;
  final Function(int index) removeImage;
  final Function(List<File>) addimage;

  @override
  State<CompletionDataSection> createState() => CompletionDataSectionState();
}

class CompletionDataSectionState extends State<CompletionDataSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.w24),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: context.palette.workerprimary,
                size: ScreenUtilsManager.s20,
              ),
              SizedBox(width: ScreenUtilsManager.w8),
              Text(
                S.of(context).completionData,
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilsManager.h24),
          Text(
            S.of(context).proofOfWork,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s12,
              fontWeight: FontWeight.bold,
              color: context.palette.grey700,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          StreamBuilder<List<File>>(
            stream: widget.streamController.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
                  final bool hasImages =
                      snapshot.data != null && snapshot.data!.isNotEmpty;
                  if (hasImages) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final images = await showImageBottomSheet(context);
                            if (images != null && images.isNotEmpty) {
                              widget.addimage(images);
                            }
                          },
                          borderRadius: BorderRadius.circular(
                            ScreenUtilsManager.r12,
                          ),
                          child: DottedBorder(
                            child: Container(
                              height: ScreenUtilsManager.h105,
                              width: ScreenUtilsManager.w80,
                              padding: EdgeInsets.all(ScreenUtilsManager.w8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: ScreenUtilsManager.s28,
                                    color: context.palette.grey600,
                                  ),
                                  SizedBox(height: ScreenUtilsManager.h4),
                                  Text(
                                    S.of(context).add,
                                    style: GoogleFonts.cairo(
                                      color: context.palette.grey700,
                                      fontSize: ScreenUtilsManager.s13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtilsManager.w12),
                        Expanded(
                          child: ImageWorkerPickerList(
                            files: snapshot.data!,
                            onRemove: (int index) {
                              widget.removeImage(index);
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        final images = await showImageBottomSheet(context);
                        if (images != null && images.isNotEmpty) {
                          widget.addimage(images);
                        }
                      },
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r12,
                      ),
                      child: DottedBorder(
                        child: Container(
                          height: ScreenUtilsManager.h120,
                          width: double.infinity,
                          padding: EdgeInsets.all(ScreenUtilsManager.w8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: ScreenUtilsManager.s28,
                                color: context.palette.grey600,
                              ),
                              SizedBox(height: ScreenUtilsManager.h8),
                              Text(
                                S.of(context).uploadCompletionImages,
                                style: GoogleFonts.cairo(
                                  color: context.palette.grey700,
                                  fontSize: ScreenUtilsManager.s14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
          ),
          SizedBox(height: ScreenUtilsManager.h24),

          Text(
            S.of(context).completionNotes,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s12,
              fontWeight: FontWeight.bold,
              color: context.palette.grey700,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          CustomTextfromfield(
            controller: widget.notesController,
            hinttext: S.of(context).addNotesHint,
            lable: S.of(context).notesLabel,
          ),
        ],
      ),
    );
  }
}

class MarkAsCompletedButton extends StatelessWidget {
  const MarkAsCompletedButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.palette.completedButton,
        foregroundColor: context.palette.white,
        elevation: ScreenUtilsManager.s4,
        shadowColor: context.palette.completedButton.withValues(alpha: 0.4),
        minimumSize: Size(double.infinity, ScreenUtilsManager.h56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: ScreenUtilsManager.h24,
              width: ScreenUtilsManager.w24,
              child: CircularProgressIndicator(
                color: context.palette.white,
                strokeWidth: ScreenUtilsManager.s2_5,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified, size: ScreenUtilsManager.s24),
                SizedBox(width: ScreenUtilsManager.w10),
                Text(
                  S.of(context).markAsCompletedBtn,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: ScreenUtilsManager.s0_3,
                  ),
                ),
              ],
            ),
    );
  }
}
