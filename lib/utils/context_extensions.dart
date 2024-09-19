import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_app/resource/colors.dart';
import 'package:product_app/utils/custom_toast_module.dart';
import 'package:product_app/utils/image_module.dart';
import 'package:product_app/utils/text_utils.dart';

extension BuildContextExtensionFunctions on BuildContext {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static late FToast fToast;

  void showToast(String text, {bool showLongToast = false}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: text,
        toastLength: showLongToast ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,);
  }

  void afterWidgetBuilt(Function() functionToCall, {Function()? checkMounted}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => functionToCall());
    if (checkMounted != null) {
      if (mounted) {
        checkMounted();
      }
    }
  }

  double getWidth() => MediaQuery.of(this).size.width;

  double getHeight() => MediaQuery.of(this).size.height;

  double getPercentWidth(double percentage) =>
      MediaQuery.of(this).size.width * percentage;

  double getPercentHeight(double percentage) =>
      MediaQuery.of(this).size.height * percentage;

  Widget paddingHorizontal(double size) {
    return SizedBox(
      width: size,
    );
  }

  Widget paddingVertical(double size) {
    return SizedBox(
      height: size,
    );
  }

  Future<void> delayInMilliseconds({
    int time = 200,
    required Function() afterDelay,
  }) async {
    await Future.delayed(Duration(milliseconds: time));
    afterDelay();
  }
  
  void showFailureMessage(String message) {
    ToastMessage.show(
      message,
      this,
      false,
      false,
      3,
      null,
    );
  }

  void showSuccessMessage(String message) {
    ToastMessage.show(
      message,
      this,
      true,
      false,
      3,
      null,
    );
  }

  void showActionableToast({
    required String messageText,
    String? actionableText,
    required bool isSuccess,
    required bool isIconNeeded,
    required String imageData,
    double marginBottom = 120,
    int duration = 2,
    Function()? onAction,
  }) {
    fToast = FToast();
    fToast.init(this);
    Widget toast = Container(
      width: getWidth(),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSuccess ? AppColors.color219451 : AppColors.colorB71209,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isIconNeeded) ...[
            AssetImageWidget(
              imageData: imageData,
              imageWidth: 15,
              imageHeight: 15,
            ),
            paddingHorizontal(10),
          ],
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Text(
              messageText,
              textAlign: TextAlign.start,
              maxLines: 7,
              style: CustomTextUtils.showInterStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                fontColor: AppColors.colorffffff,
              ),
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
      positionedToastBuilder: (context, child) {
        return Positioned(
          bottom: marginBottom + MediaQuery.of(context).viewInsets.bottom,
          left: 0,
          right: 0,
          child: child,
        );
      },
    );
  }

}