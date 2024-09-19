import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextUtils {
  CustomTextUtils._();

  static TextStyle showInterStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color fontColor,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: fontColor,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: fontColor,
      ),
    );
  }

  static TextStyle showPoppinsStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color fontColor,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: fontColor,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: fontColor,
      ),
    );
  }

  static TextStyle showMontserratStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color fontColor,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: fontColor,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: fontColor,
      ),
    );
  }

  static TextStyle showCambayStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color fontColor,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.cambay(
      textStyle: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: fontColor,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: fontColor,
      ),
    );
  }
}
