import 'package:citifix/core/function/imagebutton.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/ReportScreenController/reportscreencontroller.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ImagePickerList.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/ReportRequestModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ReportForms.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/addreportAppbar.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/extensionvediotype.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  ReportScreenController reportscreencontroller = ReportScreenController();

  @override
  void initState() {
    super.initState();
    reportscreencontroller.init();
  }

  @override
  void dispose() {
    reportscreencontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportCubit, ReportManagerState>(
      listener: (context, state) async {
        if (state is CreateReportSuccess) {
          Customsnackbar.show(
            context: context,
            backgroundColor: context.palette.green,
            message: S.of(context).reportSentSuccess,
          );
          Navigator.pop(context);
        } else if (state is CreateReportFailure) {
          Customsnackbar.show(
            context: context,
            backgroundColor: context.palette.red,
            message: state.errMessage,
          );
        }
      },
      builder: (context, state) {
        bool inAsyncCall = state is CreateReportLoading;

        return ModalProgressHUD(
          inAsyncCall: inAsyncCall,
          blur: 7,
          progressIndicator: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is CreateReportLoading) ...[
                customloading(),
                if (state.isCompressing) ...[
                  SizedBox(height: 10),
                  Text(
                    S.of(context).compressingVideo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(end: state.progress.clamp(0.0, 1.0)),
                      duration: Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          backgroundColor: context.palette.surfaceContainerHigh,
                          minHeight: 10,
                          value: value,
                          color: context.palette.primary,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${(state.progress * 100).toInt()}%",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ],
          ),
          child: Scaffold(
            backgroundColor: context.palette.bgBackground,
            appBar: AddReportAppbar(context),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.p23,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenUtilsManager.h40),
                      ReportFormFields(
                        titleController: reportscreencontroller.titleController,
                        descriptionController:
                            reportscreencontroller.descriptionController,
                        onCategoryChanged: (p1) {
                          reportscreencontroller.categoryItem = p1?.id ?? -1;
                          reportscreencontroller.updateButtonStatus();
                        },
                      ),

                      SizedBox(height: ScreenUtilsManager.h16),

                      ImagePickerList(
                        images: reportscreencontroller.selectedFiles,
                        onAddImage: () {
                          reportscreencontroller.pickImages(context);
                        },
                        stream: reportscreencontroller.streamController.stream,
                        onRemove: (int index) {
                          reportscreencontroller.selectedFiles.removeAt(index);
                          reportscreencontroller.streamController.add(
                            reportscreencontroller.selectedFiles,
                          );
                          reportscreencontroller.updateButtonStatus();
                        },
                      ),
                      SizedBox(height: ScreenUtilsManager.h16),
                      Text(
                        S.of(context).location,
                        style: GoogleFonts.cairo(
                          color: context.palette.kPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtilsManager.s16,
                        ),
                      ),

                      SizedBox(height: ScreenUtilsManager.h16),

                      CustomMap.fromDevice(
                        allowSelection: true,
                        onmapCreated: (String street, LatLng latlang) {
                          reportscreencontroller.selectedStreet = street;
                          reportscreencontroller.selectedLatLng = latlang;
                        },
                      ),
                      SizedBox(height: ScreenUtilsManager.h16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: reportscreencontroller.isAnonymous,
                            activeColor: context.palette.kPrimary,
                            onChanged: (bool? value) {
                              setState(() {
                                reportscreencontroller.isAnonymous =
                                    value ?? false;
                              });
                            },
                          ),
                          Text(
                            S.of(context).sendAnonymously,
                            style: GoogleFonts.cairo(
                              color: context.palette.kPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtilsManager.h24),

                      StreamBuilder<bool>(
                        initialData: false,
                        stream: reportscreencontroller.btnController.stream,
                        builder:
                            (
                              BuildContext context,
                              AsyncSnapshot<bool> snapshot,
                            ) => CustomButton(
                              onPressed: snapshot.data == true
                                  ? () {
                                      context.read<ReportCubit>().createReport(
                                        request: CreateReportRequest(
                                          title: reportscreencontroller
                                              .titleController
                                              .text,
                                          description: reportscreencontroller
                                              .descriptionController
                                              .text,
                                          location:
                                              reportscreencontroller
                                                  .selectedStreet ??
                                              S.of(context).unknownLocation,
                                          latitude:
                                              reportscreencontroller
                                                  .selectedLatLng
                                                  ?.latitude ??
                                              0.0,
                                          longitude:
                                              reportscreencontroller
                                                  .selectedLatLng
                                                  ?.longitude ??
                                              0.0,
                                          categoryId: reportscreencontroller
                                              .categoryItem,
                                          images: reportscreencontroller
                                              .selectedFiles
                                              .where((e) => e.isImage)
                                              .toList()
                                              .map((e) => e.path)
                                              .toList(),
                                          videos: reportscreencontroller
                                              .selectedFiles
                                              .where((e) => e.isVideo)
                                              .toList()
                                              .map((e) => e.path)
                                              .toList(),
                                          isAnonymous: reportscreencontroller
                                              .isAnonymous,
                                        ),
                                      );
                                    }
                                  : null,
                              lable: S.of(context).sendReport,
                            ),
                      ),

                      SizedBox(height: ScreenUtilsManager.h24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
