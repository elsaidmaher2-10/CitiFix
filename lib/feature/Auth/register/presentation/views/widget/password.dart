import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/visblitypassword/visibleeye_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.onChanged,
    this.isNew = false,
    this.label,
    this.hintText,
    this.showLabel = true,
    this.isRequired = false,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool isNew;
  final String? label;
  final String? hintText;
  final bool showLabel;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = context.palette.kPrimary;

    return BlocProvider(
      create: (_) => VisibleeyeCubit(),
      child: BlocBuilder<VisibleeyeCubit, bool>(
        builder: (context, isHidden) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showLabel) ...[
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtilsManager.w4,
                    bottom: ScreenUtilsManager.h4,
                  ),
                  child: Row(
                    children: [
                      Text(
                        label ??
                            (isNew
                                ? S.of(context).newPassword
                                : S.of(context).password),
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s14,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? context.palette.onSurface.withValues(alpha: 0.9)
                              : context.palette.onSurfaceVariant,
                        ),
                      ),
                      if (isRequired)
                        Padding(
                          padding: EdgeInsets.only(left: ScreenUtilsManager.w4),
                          child: Text(
                            '*',
                            style: TextStyle(
                              fontSize: ScreenUtilsManager.s14,
                              fontWeight: FontWeight.bold,
                              color: context.palette.error,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h8),
              ],

              // Custom Text Field
              CustomTextfromfield(
                maxLines: 1,
                controller: controller,
                onChanged: onChanged,
                obstext: isHidden,
                hinttext:
                    hintText ??
                    (isNew
                        ? S.of(context).enterNewPassword
                        : S.of(context).hintPassword),
                lable: '', // Empty string since we show custom label above
                prefix: Icon(
                  isNew ? Icons.lock_outline : Icons.password_outlined,
                  color: isDark
                      ? primaryColor.withValues(alpha: 0.7)
                      : context.palette.lightGrey2,
                  size: ScreenUtilsManager.s20,
                ),
                suffix: IconButton(
                  onPressed: () {
                    context.read<VisibleeyeCubit>().chanagevisbilitypassword();
                  },
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                    color: isDark
                        ? context.palette.onSurfaceVariant.withValues(alpha: 0.7)
                        : context.palette.lightGrey2,
                    size: ScreenUtilsManager.s20,
                  ),
                ),
                isworker: false,
                color: isDark
                    ? Theme.of(context).colorScheme.surfaceContainerHighest
                    : const Color(0xffF6F6F6),
              ),
              SizedBox(height: ScreenUtilsManager.h8),
            ],
          );
        },
      ),
    );
  }
}
