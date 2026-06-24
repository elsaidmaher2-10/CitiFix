import 'package:citifix/core/function/_isValidEmail.dart';
import 'package:citifix/core/function/_isValidPhone.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';

String? phonevalidator(BuildContext context, String? value) {
  if (value == null || value.trim().isEmpty) {
    return S.of(context).phoneRequired;
  }
  if (!isValidPhone(value.trim())) {
    return S.of(context).invalidPhone;
  }
  return null;
}

String? emailvalidator(BuildContext context, String? value) {
  if (value == null || value.trim().isEmpty) {
    return S.of(context).emailRequired;
  }
  if (!isValidEmail(value.trim())) {
    return S.of(context).invalidEmail;
  }
  return null;
}

String? lnamevalidator(BuildContext context, String? value) {
  if (value == null || value.trim().isEmpty) {
    return S.of(context).lastNameRequired;
  }
  return null;
}

String? fnamevalidator(BuildContext context, String? value) {
  if (value == null || value.trim().isEmpty) {
    return S.of(context).firstNameRequired;
  }
  return null;
}

String? confvalidator(
  BuildContext context,
  String? value,
  dynamic passwordController,
) {
  if (value == null || value.isEmpty) {
    return S.of(context).confirmPasswordRequired;
  }
  if (value != passwordController.text) {
    return S.of(context).passwordNotMatch;
  }
  return null;
}

String? loginPasswordValidator(BuildContext context, String? value) {
  if (value == null || value.trim().isEmpty) {
    return S.of(context).passwordRequired;
  }
  if (value.trim().length < 8) {
    return S.of(context).passwordMinLength;
  }
  return null;
}

String? nationalIdValidator(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return S.of(context).nationalIdRequired;
  }

  if (value.length != 14) {
    return S.of(context).nationalIdLength;
  }

  if (!RegExp(r'^\d{14}$').hasMatch(value)) {
    return S.of(context).nationalIdDigits;
  }

  return null;
}

String getRuleText(BuildContext context, String key) {
  switch (key) {
    case "Minimum characters 8":
    case "Minimum characters 12":
      return S.of(context).passwordMinLength;

    case "One uppercase character":
      return S.of(context).passwordUppercase;

    case "One lowercase character":
      return S.of(context).passwordLowercase;

    case "One special character":
      return S.of(context).passwordSpecialChar;

    case "One number":
      return S.of(context).passwordNumber;

    default:
      return "";
  }
}
