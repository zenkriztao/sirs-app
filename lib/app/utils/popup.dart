import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:sirs_apps/app/utils/constants.dart';

void showPanaraDialog(String title, String message,
    [String? buttonText = "Tutup", void Function()? function]) {
  PanaraInfoDialog.show(
    Get.context!,
    title: title,
    message: message,
    buttonText: buttonText!,
    onTapDismiss: () {
      Navigator.pop(Get.context!);
      if (function != null) function();
    },
    panaraDialogType: PanaraDialogType.custom,
    color: kPrimaryblue500,
    barrierDismissible: false,
  );
}
