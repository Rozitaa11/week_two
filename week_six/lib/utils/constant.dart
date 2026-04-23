import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:week_six/main.dart';
import 'package:week_six/utils/app_str.dart';

String lottieURL = 'assets/lottie/1.json';
//empty title or subtitle textfield warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You must fill all the fields!',
    corner: 20,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}

// nothing tenterned qhen user try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You must edit task then try to update it!',
    corner: 20,
    duration: 3000,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}

//no Tasj warning dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message: 'There is no task to delete!',
    buttonText: 'Okay',
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

//delete all the tasks from DB
dynamic deleteAllTasksWarning(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouhintSure,
    message: 'Are you sure you want to delete all tasks?',
    confirmButtonText: 'yes',
    cancelButtonText: 'No',
    onTapConfirm: () {
      // we will clear the box and pop the dialog
      BaseWidget.of(context).dataStore.box.clear;
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },

    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
