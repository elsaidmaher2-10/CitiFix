import 'dart:async';
import 'package:citifix/App/manager/cubit/localization_controller_cubit.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Auth/Login/presentation/manager/cubit/loginmanger_cubit.dart';
import 'package:citifix/feature/Auth/Login/presentation/manager/cubit/loginmanger_state.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/categortrepos/categoryrepos.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/categoryManger/category_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/workerFeature/home/data/repo/homrepo.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/dashbroadHomemanager/cubit/dashbroad_home_manager_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:citifix/core/function/sinupvalidator.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/resource/constantmanger.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  StreamController<bool> streamController = StreamController.broadcast();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void isvisible() {
    _isVisible = !_isVisible;
    streamController.add(_isVisible);
  }

  bool isvalidpass = false;
  bool isvalidemail = false;
  bool ischeck = false;

  StreamController<bool> btnController = StreamController.broadcast();
  @override
  void dispose() {
    streamController.close();
    password.dispose();
    email.dispose();
    btnController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 0),
        ),
      );

      await remoteConfig.fetchAndActivate();

      String requiredVersion = remoteConfig.getString('min_version');
      String updateUrl = remoteConfig.getString('update_url');

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      if (requiredVersion.isNotEmpty && currentVersion != requiredVersion) {
        _showForceUpdateDialog(updateUrl);
      }
    } catch (e) {
      print("Error checking updates: $e");
    }
  }

  Future<void> _preloadCitizenData() async {
    if (!mounted) return;

    try {
      await Future.wait<void>([
        getIt<ReportCubit>().fetchReports(isRefresh: true),
        context.read<UserProfileInfoCubit>().getUserProfleInfo(),
        context.read<NotificationCubit>().getNotifications(),
        CategoryCubit(getIt<CategoryRepository>()).fetchCategories(),
      ]);
    } catch (error) {
      debugPrint('Failed to preload citizen data: $error');
    }
  }

  Future<void> _preloadWorkerData() async {
    if (!mounted) return;

    try {
      await Future.wait<void>([
        context.read<NotificationCubit>().getNotifications(),
        HomeCubit(getIt<Homreposatory>()).getWorkerDashboard(),
      ]);
    } catch (error) {
      debugPrint('Failed to preload worker data: $error');
    }
  }

  void _showForceUpdateDialog(String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text("تحديث هام متاح! 🚀"),
          content: const Text(
            "تم إطلاق نسخة جديدة من التطبيق. يجب عليك التحديث للاستمرار في الاستخدام.",
          ),
          actions: [
            ElevatedButton(
              child: const Text("تحميل التحديث"),
              onPressed: () async {
                final Uri updateUri = Uri.parse(url);
                if (await canLaunchUrl(updateUri)) {
                  await launchUrl(
                    updateUri,
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginmangerCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<LoginmangerCubit, LogincontrollerState>(
            listener: (context, state) async {
              if (state is LogincontrollerFailure) {
                if (state.message.contains(
                  "Email not confirmed. Please check your email to confirm your account.",
                )) {
                  Navigator.pushNamed(
                    context,
                    Routes.otpverficationc,
                    arguments: {
                      Constantmanger.email: email.text.trim(),
                      Constantmanger.screen: Constantmanger.logIn,
                    },
                  );

                  Customsnackbar.show(
                    context: context,
                    backgroundColor: context.palette.red,
                    message: state.message,
                  );
                }
                Customsnackbar.show(
                  context: context,
                  backgroundColor: context.palette.red,
                  message: state.message,
                );
              } else if (state is LogincontrollerSuccess) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: context.palette.green,
                  message: state.response.message,
                );

                final AppRole role = AppRole.fromString(state.response.role);
                if (role == AppRole.citizen) {
                  await _preloadCitizenData();
                } else if (role == AppRole.worker) {
                  await _preloadWorkerData();
                }

                if (!mounted) return;

                switch (role) {
                  case AppRole.citizen:
                    Navigator.pushNamed(context, Routes.citizenMain);
                    break;
                  case AppRole.worker:
                    Navigator.pushNamed(context, Routes.workerMain);
                    break;
                  case AppRole.unknown:
                    Navigator.pushNamed(context, Routes.login);
                    break;
                }
              }
            },
            builder: (context, state) {
              bool inAsyncCall = false;
              if (state is LogincontrollerLoading) {
                inAsyncCall = true;
              } else {
                inAsyncCall = false;
              }

              return ModalProgressHUD(
                inAsyncCall: inAsyncCall,
                blur: 7,
                progressIndicator: customloading(),
                child: Scaffold(
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).dontHaveAccount,
                          style: GoogleFonts.cairo(
                            color: context.palette.lightGrey2,
                          ),
                        ),
                        SizedBox(width: ScreenUtilsManager.w4),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.signup);
                          },
                          child: Text(
                            S.of(context).signUpNow,
                            style: GoogleFonts.cairo(
                              color: context.palette.kPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  resizeToAvoidBottomInset: true,
                  extendBody: true,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.h18,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenUtilsManager.h12,
                                  bottom: ScreenUtilsManager.h8,
                                ),
                                child:
                                    BlocBuilder<
                                      LocalizationControllerCubit,
                                      LocalizationControllerState
                                    >(
                                      builder: (context, state) {
                                        final String lang =
                                            state
                                                is LocalizationControllerChanged
                                            ? state.lang
                                            : 'en';
                                        return SegmentedButton<String>(
                                          style: SegmentedButton.styleFrom(
                                            selectedBackgroundColor:
                                                context.palette.kPrimary,
                                            selectedForegroundColor:
                                                context.palette.white,
                                            visualDensity:
                                                VisualDensity.compact,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          segments: [
                                            ButtonSegment<String>(
                                              value: 'en',
                                              label: Text(
                                                S.of(context).english,
                                                style: GoogleFonts.cairo(
                                                  fontSize:
                                                      ScreenUtilsManager.s13,
                                                ),
                                              ),
                                            ),
                                            ButtonSegment<String>(
                                              value: 'ar',
                                              label: Text(
                                                S.of(context).arabic,
                                                style: GoogleFonts.cairo(
                                                  fontSize:
                                                      ScreenUtilsManager.s13,
                                                ),
                                              ),
                                            ),
                                          ],
                                          selected: {lang},
                                          showSelectedIcon: false,
                                          onSelectionChanged:
                                              (Set<String> selection) {
                                                if (selection.isEmpty) return;
                                                context
                                                    .read<
                                                      LocalizationControllerCubit
                                                    >()
                                                    .changeLanguage(
                                                      selection.first,
                                                    );
                                              },
                                        );
                                      },
                                    ),
                              ),
                            ),
                            SizedBox(height: ScreenUtilsManager.h20),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          colorBlendMode: BlendMode.srcOut,
                                          AssetValueManager.Klog,
                                          height: ScreenUtilsManager.h120,
                                        ),
                                        SizedBox(height: ScreenUtilsManager.h9),
                                        Text(
                                          S.of(context).logIn,
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            fontSize: ScreenUtilsManager.s34,
                                            color: context.palette.kPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtilsManager.h20),
                                  CustomTextfromfield(
                                    controller: email,
                                    prefix: Icon(
                                      Icons.email,
                                      color: context.palette.lightGrey2,
                                    ),
                                    hinttext: S.of(context).hintEmail,
                                    validator: (value) {
                                      isvalidemail =
                                          emailvalidator(context, value) == null
                                          ? true
                                          : false;
                                      btnController.add(
                                        isvalidemail && isvalidpass,
                                      );
                                      return emailvalidator(context, value);
                                    },
                                    lable: S.of(context).email,
                                  ),
                                  SizedBox(height: ScreenUtilsManager.h20),
                                  StreamBuilder<bool>(
                                    initialData: _isVisible,
                                    stream: streamController.stream,
                                    builder:
                                        (
                                          BuildContext context,
                                          AsyncSnapshot<bool> snapshot,
                                        ) {
                                          return CustomTextfromfield(
                                            prefix: Icon(
                                              Icons.password_outlined,
                                              color: context.palette.lightGrey2,
                                            ),
                                            maxLines: 1,
                                            controller: password,
                                            validator: (value) {
                                              final passwordError =
                                                  loginPasswordValidator(
                                                    context,
                                                    value,
                                                  );
                                              isvalidpass =
                                                  passwordError == null;
                                              btnController.add(
                                                isvalidemail && isvalidpass,
                                              );
                                              return passwordError;
                                            },
                                            obstext: snapshot.data ?? true,
                                            hinttext: S
                                                .of(context)
                                                .hintPassword,
                                            suffix: IconButton(
                                              onPressed: () {
                                                isvisible();
                                              },
                                              icon: Icon(
                                                snapshot.data == true
                                                    ? Icons.remove_red_eye
                                                    : Icons.visibility_off,
                                                color:
                                                    context.palette.lightGrey3,
                                              ),
                                            ),
                                            lable: S.of(context).password,
                                          );
                                        },
                                  ),
                                  SizedBox(height: ScreenUtilsManager.h20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints.tight(
                                              Size(30, 30),
                                            ),
                                            child: Checkbox(
                                              activeColor:
                                                  context.palette.kPrimary,
                                              value: ischeck,
                                              onChanged: (onChanged) async {
                                                setState(() {});
                                                ischeck = onChanged ?? false;
                                              },
                                            ),
                                          ),
                                          Text(
                                            S.of(context).rememberMe,
                                            style: GoogleFonts.cairo(
                                              fontSize: ScreenUtilsManager.s14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.foregetpassword,
                                          );
                                        },
                                        child: Text(
                                          S.of(context).forgetPassword,
                                          style: GoogleFonts.cairo(
                                            color: context.palette.kPrimary,
                                            fontSize: ScreenUtilsManager.s14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtilsManager.h30),
                                  SizedBox(
                                    height: 50.h,
                                    width: double.infinity,
                                    child: StreamBuilder<bool>(
                                      initialData: false,
                                      stream: btnController.stream,
                                      builder:
                                          (
                                            BuildContext context,
                                            AsyncSnapshot<bool> snapshot,
                                          ) => ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  context.palette.kPrimary,
                                              foregroundColor:
                                                  context.palette.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      ScreenUtilsManager.r10,
                                                    ),
                                              ),
                                            ),
                                            onPressed: snapshot.data == true
                                                ? () {
                                                    if (formKey.currentState
                                                            ?.validate() ??
                                                        false) {
                                                      context
                                                          .read<
                                                            LoginmangerCubit
                                                          >()
                                                          .login(
                                                            email: email.text,
                                                            password:
                                                                password.text,
                                                          );
                                                    }
                                                  }
                                                : null,
                                            child: Text(
                                              S.of(context).logIn,
                                              style: GoogleFonts.cairo(),
                                            ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
