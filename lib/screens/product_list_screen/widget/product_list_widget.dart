import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_app/network/model/product_list_model/product_list_model.dart';
import 'package:product_app/resource/colors.dart';
import 'package:product_app/resource/strings.dart';
import 'package:product_app/utils/context_extensions.dart';
import 'package:product_app/utils/image_module.dart';
import 'package:product_app/utils/number_extension.dart';
import 'package:product_app/utils/string_extension.dart';
import 'package:product_app/utils/text_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductListModel> productList;
  final TextEditingController serachController;
  final Function searchProducts;
  final FocusNode focusNode;
  final ScrollController listViewController;
  final Function clickOnProduct;

  const ProductListWidget({
    super.key,
    required this.productList,
    required this.searchProducts,
    required this.serachController,
    required this.focusNode,
    required this.listViewController,
    required this.clickOnProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: context.getWidth(),
        height: context.getHeight(),
        color: AppColors.colorffffff,
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.paddingVertical(60),
              _buildSearchWidget(context: context),
              context.paddingVertical(20),
              if(productList.isEmpty && serachController.text.isEmpty)...[
                const IgnorePointer(),
              ] else if(serachController.text.isNotEmpty && productList.isEmpty)...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Strings.noDataFound,
                      style: CustomTextUtils.showMontserratStyle(fontSize: 18, fontWeight: FontWeight.w500, fontColor: AppColors.color989898),
                    ),
                  ),
                ),
              ] else...[
                _buildProductList(context: context),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList({
    required BuildContext context,
  }) {
    return GridView.builder(
      controller: listViewController,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      cacheExtent: 10,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: (120.0 / 210.0),
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        var item = productList[index];
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            clickOnProduct(item);
          },
          child: _buildGridWidget(
            productID: item.id!,
            imageUrl: item.image!,
            title: item.title!,
            actualPrice: item.price!,
            context: context,
            width: 53.w,
            height: 26.h,
          ),
        );
      },
    );
  }

  Widget _buildGridWidget({
    required int productID,
    required String imageUrl,
    required String title,
    required double actualPrice,
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CacheImageWidget(
            imageWidth: width,
            imageHeight: height,
            imageUrl: imageUrl,
            boxFit: BoxFit.contain,
          ),
        ),
        context.paddingVertical(15),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: CustomTextUtils.showPoppinsStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.color000000,
          ),
        ),
        context.paddingVertical(5),
        Text(
          actualPrice != 0
              ? actualPrice.convertCurrencyInBottomSheet(actualPrice, false)
              : Strings.na,
          style: CustomTextUtils.showInterStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.colorB500FF,
          ),
        ),
        context.paddingVertical(10),
      ],
    );
  }

  Widget _buildSearchWidget({
    required BuildContext context,
  }) {
    return Container(
      width: context.getWidth(),
      height: 5.h,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.color000000.withOpacity(0.10),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: TextField(
                controller: serachController,
                maxLines: 1,
                autofocus: false,
                focusNode: focusNode,
                cursorColor: AppColors.color000000,
                textAlign: TextAlign.left,
                style: CustomTextUtils.showPoppinsStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.color000000,
                ),
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[A-Za-z ]'),
                  ),
                  NoLeadingSpaceFormatter(),
                  FilteringTextInputFormatter.deny(' '),
                  FirstUpperCaseTextFormatter(),
                ],
                onChanged: (val) {
                  searchProducts();
                },
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  counterText: "",
                  hintText: Strings.hintText,
                  hintStyle: CustomTextUtils.showPoppinsStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.color000000.withOpacity(0.45),
                  ),
                ),
              ),
            ),
          ),
          Icon(
            Icons.search,
            size: 25,
            color: AppColors.color000000.withOpacity(0.45),
          ),
        ],
      ),
    );
  }
}
