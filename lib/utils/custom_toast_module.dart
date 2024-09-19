import 'package:flutter/material.dart';
import 'package:product_app/resource/strings.dart';
import 'package:product_app/utils/context_extensions.dart';

class ToastMessage {
  static void show(
    String msg,
    BuildContext context,
    bool isSuccess,
    bool isIconNeeded,
    int duration,
    String? imageData,
  ) {
    if (msg != Strings.noInternetAlert) {
      context.showActionableToast(
        messageText: msg,
        isSuccess: isSuccess,
        isIconNeeded: isIconNeeded,
        duration: duration,
        imageData: imageData ?? "",
      );
    }
  }
}
