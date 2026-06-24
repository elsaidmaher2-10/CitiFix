import 'dart:async';

import 'package:citifix/core/function/sinupvalidator.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Auth/foregetpassword/presentation/manager/ForgetpasswordState.dart';
import 'package:citifix/feature/Auth/foregetpassword/presentation/manager/forgetpasswordcubit.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Foregetpassword extends StatefulWidget {
  const Foregetpassword({super.key});

  @override
  State<Foregetpassword> createState() => _ForegetpasswordState();
}

class _ForegetpasswordState extends State<Foregetpassword> {
  bool isvalid = false;
  final StreamController<bool> streamController =
      StreamController<bool>.broadcast();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    streamController.close();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Forgetpasswordcubit(),
      child: BlocConsumer<Forgetpasswordcubit, Forgetpasswordstate>(
        listener: (context, state) async {
          if (state is ForgetpasswordstatecontrollerFailure) {
            Customsnackbar.show(
              context: context,
              backgroundColor: context.palette.red,
              message: state.message,
            );
          } else if (state is ForgetpasswordstatecontrollerSuccess) {
            Customsnackbar.show(
              context: context,
              backgroundColor: context.palette.green,
              message: state.response,
            );

            Future.delayed(
              const Duration(seconds: 3),
              () => Navigator.pushNamed(
                context,
                Routes.otpverficationc,
                arguments: {
                  Constantmanger.email: emailController.text.trim(),
                  Constantmanger.screen: Constantmanger.forgetPassword,
                },
              ),
            );
          }
        },
        builder: (context, state) {
          final inAsyncCall = state is ForgetpasswordstatecontrollerLoading;

          return ModalProgressHUD(
            inAsyncCall: inAsyncCall,
            blur: 7,
            color: Colors.white,
            opacity: 0.5,
            progressIndicator: customloading(),
            child: Scaffold(
              backgroundColor: context.palette.white,
              appBar: foregetpasswordappbar(context),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.w24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      Center(
                        child: Icon(
                          Icons.lock_reset_rounded,
                          size: 80.r,
                          color: context.palette.kPrimary.withOpacity(0.8),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      Text(
                        S.of(context).forgetPasswordDesc,
                        style: GoogleFonts.cairo(
                          color: context.palette.lightGrey2,
                          fontSize: ScreenUtilsManager.s14,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40.h),

                      Email(
                        controller: emailController,
                        validator: (validator) {
                          final result = emailvalidator(context, validator);

                          isvalid = result == null;

                          streamController.add(isvalid);

                          return result;
                        },
                      ),

                      SizedBox(height: 60.h),

                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: StreamBuilder<bool>(
                          initialData: false,
                          stream: streamController.stream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.palette.kPrimary,
                                foregroundColor: context.palette.white,
                                disabledForegroundColor: Colors.white70,
                                elevation: 2,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtilsManager.r10,
                                  ),
                                ),
                              ),
                              onPressed: snapshot.data == true
                                  ? () {
                                      FocusScope.of(context).unfocus();

                                      context
                                          .read<Forgetpasswordcubit>()
                                          .forgetpassword(
                                            isreset: true,
                                            email: emailController.text.trim(),
                                            purpose: S
                                                .of(context)
                                                .resetPasswordPurpose,
                                          );
                                    }
                                  : null,
                              child: Text(
                                S.of(context).sendCode,
                                style: GoogleFonts.cairo(
                                  fontSize: ScreenUtilsManager.s16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

PreferredSizeWidget foregetpasswordappbar(BuildContext context) {
  return AppBar(
    titleSpacing: 3.w,
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    title: Text(
      S.of(context).forgetPasswordTitle,
      style: GoogleFonts.cairo(
        color: context.palette.kPrimary,
        fontSize: ScreenUtilsManager.s20,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: context.palette.white,
    leadingWidth: 50.w,
    leading: Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: IconButton(
        splashRadius: 24,

        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          CupertinoIcons.back,
          color: context.palette.kPrimary,
          size: 28.r,
        ),
      ),
    ),
  );
}
