import 'package:flutter/material.dart';
import 'package:product_app/resource/colors.dart';
import 'package:product_app/resource/strings.dart';
import 'package:product_app/utils/context_extensions.dart';
import 'package:product_app/utils/text_utils.dart';
import 'package:typewritertext/typewritertext.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: context.getHeight(),
      color: AppColors.color8784D3,
      child: Center(
        child: TypeWriter.text(
          Strings.appName,
          maxLines: 2,
          textAlign: TextAlign.center,
          softWrap: true,
          maintainSize: false,
          style: CustomTextUtils.showPoppinsStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.colorffffff,
          ),
          duration: const Duration(milliseconds: 50),
        ),
      ),
    );
  }
}
