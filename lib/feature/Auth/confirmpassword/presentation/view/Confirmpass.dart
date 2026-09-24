import 'dart:async';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/function/passvlidatorrules.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Auth/confirmpassword/data/repo/confirmpasswordrepo.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/manager/ConfirmPasswordController.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/manager/ConfirmPasswordState.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/manager/controller/Confirmpassword.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/view/widget/confirmpassappbar.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:citifix/core/resource/constantmanger.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  late ConfirmpasswordController confirmPasswordController;
  bool _isProfileScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    _isProfileScreen = args['screen'] == 'profile';

    confirmPasswordController = ConfirmpasswordController();
    confirmPasswordController.initState(isProfileScreen: _isProfileScreen);
  }

  Widget _buildForgotPasswordFields(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtilsManager.h16),
        PasswordField(
          isNew: false,
          controller: confirmPasswordController.passwordController,
          onChanged: (value) {
            confirmPasswordController.forgotPasswordStreamController.add(
              passwordvalidatorrules(value),
            );
          },
        ),
        const SizedBox(height: 16),
        PasswordRules(
          streamController:
              confirmPasswordController.forgotPasswordStreamController,
        ),
        const SizedBox(height: 8),
        ConfirmPassword(
          controller: confirmPasswordController.confirmPasswordController,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return S.of(context).enterConfirmPassword;
            }
            if (confirmPasswordController.passwordController.text != value) {
              return S.of(context).passwordsDoNotMatch;
            }
            return null;
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildChangePasswordFields(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtilsManager.h8),
        PasswordField(
          isNew: false,
          controller: confirmPasswordController.oldPasswordController,
          onChanged: (_) {},
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        PasswordField(
          isNew: true,
          controller: confirmPasswordController.newPasswordController,
          onChanged: (value) {
            confirmPasswordController.changePasswordStreamController.add(
              passwordvalidatorrules(value),
            );
          },
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        PasswordRules(
          streamController:
              confirmPasswordController.changePasswordStreamController,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    return BlocProvider(
      create: (context) => ConfirmPasswordController(
        Confirmpasswordrepo(
          service: Apiservice(Dio()),
          networkChecker: InternetChecker(),
        ),
      ),
      child:
          BlocConsumer<
            ConfirmPasswordController,
            ConfirmPasswordControllerState
          >(
            listener: (context, state) async {
              if (state is ConfirmPasswordControllerFailure) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: context.palette.red,
                  message: state.message,
                );
              } else if (state is ChangePasswordFailure) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: context.palette.red,
                  message: state.message,
                );
              } else if (state is ConfirmPasswordControllerSuccess) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: context.palette.green,
                  message: state.message,
                );
                await Future.delayed(
                  const Duration(seconds: 3),
                  () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (Route route) => false,
                  ),
                );
              } else if (state is ChangePasswordSuccess) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: context.palette.green,
                  message: state.message,
                );

                final role = PrefrenceManager().getstring(Constantmanger.role);
                await Future.delayed(
                  const Duration(seconds: 2),
                  () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    role == "Worker" ? Routes.workerMain : Routes.citizenMain,
                    (Route route) => false,
                  ),
                );
              }
            },
            builder: (context, state) {
              final bool inAsyncCall =
                  state is ConfirmPasswordControllerLoading ||
                  state is ChangePasswordLoading;

              return ModalProgressHUD(
                inAsyncCall: inAsyncCall,
                blur: 7,
                progressIndicator: customloading(),
                child: Scaffold(
                  backgroundColor: isDark
                      ? Theme.of(context).colorScheme.surface
                      : Colors.white,
                  appBar: confirmpassappbar(context, () {
                    Navigator.pop(context);
                  }),
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (args["screen"] == "profile")
                              _buildChangePasswordFields(context, isDark)
                            else
                              _buildForgotPasswordFields(context, isDark),

                            SizedBox(height: ScreenUtilsManager.h24),
                            _buildSubmitButton(context, args, isDark),
                            SizedBox(height: ScreenUtilsManager.h32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, Map args, bool isDark) {
    final isProfileScreen = args["screen"] == "profile";

    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: StreamBuilder<bool>(
        initialData: false,
        stream: confirmPasswordController.btnController.stream,
        builder: (context, snapshot) {
          final isEnabled = snapshot.data == true;
          final buttonColor = isEnabled
              ? (isDark ? context.palette.kPrimary : context.palette.kPrimary)
              : (isDark
                    ? context.palette.outline.withValues(alpha: 0.3)
                    : context.palette.lightGrey);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
              boxShadow: isEnabled && !isDark
                  ? [
                      BoxShadow(
                        color: context.palette.kPrimary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ElevatedButton(
              onPressed: isEnabled
                  ? () {
                      if (isProfileScreen) {
                        context
                            .read<ConfirmPasswordController>()
                            .changePassword(
                              newPassword: confirmPasswordController
                                  .newPasswordController
                                  .text,
                              currentPassword: confirmPasswordController
                                  .oldPasswordController
                                  .text,
                            );
                      } else {
                        context
                            .read<ConfirmPasswordController>()
                            .createnewpassword(
                              email: args[Constantmanger.email],
                              newPassword: confirmPasswordController
                                  .confirmPasswordController
                                  .text,
                              otp: args["otp"],
                            );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor: isDark
                    ? context.palette.surfaceContainerHighest
                    : context.palette.lightGrey,
                disabledForegroundColor: isDark
                    ? context.palette.onSurfaceVariant
                    : context.palette.lightGrey2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                ),
                elevation: isEnabled && !isDark ? 2 : 0,
                padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h14),
              ),
              child: Text(
                S.of(context).submit,
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
