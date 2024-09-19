import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/network/model/product_list_model/product_list_model.dart';
import 'package:product_app/resource/colors.dart';
import 'package:product_app/resource/images.dart';
import 'package:product_app/utils/context_extensions.dart';
import 'package:product_app/utils/image_module.dart';
import 'package:product_app/utils/number_extension.dart';
import 'package:product_app/utils/text_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductListModel data;
  final bool isFav;
  final Function addRemoveFromList;

  const ProductDetailsWidget({
    super.key,
    required this.data,
    required this.isFav,
    required this.addRemoveFromList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: context.getHeight(),
      color: AppColors.colorffffff,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.paddingVertical(60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: 25,
                      color: AppColors.color000000,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      addRemoveFromList(
                        data.id,
                        isFav,
                      );
                    },
                    child: AssetImageWidget(
                      imageData:
                          isFav ? Images.productWishlist : Images.loveBlack,
                      imageWidth: 25,
                      imageHeight: 25,
                    ),
                  ),
                ],
              ),
            ),
            context.paddingVertical(20),
            CacheImageWidget(
              imageWidth: context.getWidth(),
              imageHeight: 52.h,
              imageUrl: data.image!,
              boxFit: BoxFit.contain,
            ),
            context.paddingVertical(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,),
              child: Text(
                data.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: CustomTextUtils.showPoppinsStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.color000000,
                ),
              ),
            ),
            context.paddingVertical(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,),
              child: Text(
                data.price!.convertCurrencyInBottomSheet(data.price!, false),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: CustomTextUtils.showPoppinsStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.colorB500FF,
                ),
              ),
            ),
            context.paddingVertical(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,),
              child: Text(
                data.description!,
                style: CustomTextUtils.showPoppinsStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.color000000,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
