import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppFunction {
  static void showToast({
    required String message,
    required bool isSuccess,
    required BuildContext context,
  }) {
    toastification.show(
      context: context,
      type: isSuccess ? ToastificationType.success : ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 5),
      description: Text(message),
      icon: const Icon(Icons.error),
      closeButtonShowType: CloseButtonShowType.onHover,
    );
  }
}
