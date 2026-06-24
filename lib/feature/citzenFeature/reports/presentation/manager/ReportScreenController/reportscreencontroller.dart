import 'dart:async';
import 'dart:io';
import 'package:citifix/core/widget/mediapicker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class ReportScreenController {
  final StreamController<List<File>> streamController =
      StreamController<List<File>>.broadcast();
  final StreamController<bool> btnController =
      StreamController<bool>.broadcast();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<File> selectedFiles = [];
  int categoryItem = -1;
  bool isValid = false;
  String? selectedStreet;
  LatLng? selectedLatLng;
  bool isAnonymous = false;

  final ImagePicker _imagePicker = ImagePicker();

  void init() {
    titleController.addListener(updateButtonStatus);
    descriptionController.addListener(updateButtonStatus);
  }

  void dispose() {
    streamController.close();
    btnController.close();
    titleController.dispose();
    descriptionController.dispose();
  }

  Future<void> pickImages(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (bottomSheetContext) => PickerBottomSheet(
        onCameraPhoto: () async {
          Navigator.pop(bottomSheetContext);
          await _pickFromCamera(context, isVideo: false);
        },
        onCameraVideo: () async {
          Navigator.pop(bottomSheetContext);
          await _pickFromCamera(context, isVideo: true);
        },
        onFilesSelected: (files) {
          List<File> validFiles = [];
          bool hasOversized = false;
          for (var file in files) {
            if (file.lengthSync() > 50 * 1024 * 1024) {
              hasOversized = true;
            } else {
              validFiles.add(file);
            }
          }
          if (hasOversized && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? 'بعض الملفات كبيرة جداً وتم تجاهلها (الحد الأقصى 50 ميجابايت)'
                      : 'Some files are too large and were ignored (Max 50MB)',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
          selectedFiles = [...validFiles.reversed, ...selectedFiles];
          streamController.add(selectedFiles);
          updateButtonStatus();
        },
      ),
    );
  }

  Future<void> _pickFromCamera(BuildContext context, {required bool isVideo}) async {
    try {
      if (isVideo) {
        final XFile? video = await _imagePicker.pickVideo(
          source: ImageSource.camera,
        );
        if (video != null) {
          File file = File(video.path);
          if (file.lengthSync() > 50 * 1024 * 1024) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? 'حجم الفيديو كبير جداً (الحد الأقصى 50 ميجابايت)'
                        : 'Video size is too large (Max 50MB)',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
            return;
          }
          selectedFiles = [file, ...selectedFiles];
          streamController.add(selectedFiles);
          updateButtonStatus();
        }
      } else {
        final XFile? photo = await _imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (photo != null) {
          File file = File(photo.path);
          if (file.lengthSync() > 50 * 1024 * 1024) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? 'حجم الصورة كبير جداً (الحد الأقصى 50 ميجابايت)'
                        : 'Image size is too large (Max 50MB)',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
            return;
          }
          selectedFiles = [file, ...selectedFiles];
          streamController.add(selectedFiles);
          updateButtonStatus();
        }
      }
    } catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedFiles.length) {
      selectedFiles.removeAt(index);
      streamController.add(selectedFiles);
      updateButtonStatus();
    }
  }

  void setCategory(int id) {
    categoryItem = id;
    updateButtonStatus();
  }

  void updateButtonStatus() {
    isValid =
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        categoryItem != -1 &&
        selectedFiles.isNotEmpty;
    if (!btnController.isClosed) {
      btnController.add(isValid);
    }
  }
}
