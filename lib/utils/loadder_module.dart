import 'package:flutter/material.dart';
import 'package:product_app/resource/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    required this.width,
    required this.height,
    super.key,
    this.borderRadius = 12,
  });
  final double width, height, borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.color080B2C.withOpacity(0.1),
      highlightColor: AppColors.color3568EC.withOpacity(0.6),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.color080B2C),
          color: AppColors.colorffffff,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
