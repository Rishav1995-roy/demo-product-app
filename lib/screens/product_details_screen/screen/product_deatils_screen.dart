import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/network/model/product_list_model/product_list_model.dart';
import 'package:product_app/screens/product_details_screen/widget/product_deatils_widget.dart';
import 'package:product_app/utils/context_extensions.dart';
import 'package:product_app/utils/local_storage.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductListModel productListModel;
  const ProductDetailsScreen({
    super.key,
    required this.productListModel,
  });

  static const String routeName = '/product-details-screen';

  static GoRoute route() {
    return GoRoute(
      name: 'product-details',
      path: ProductDetailsScreen.routeName,
      builder: (context, state) {
        var data = state.extra as ProductListModel;
        return ProductDetailsScreen(
          productListModel: data,
        );
      },
    );
  }

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    context.afterWidgetBuilt(() {
      updateFavData();
    });
  }

  void updateFavData() {
    List<int> dataList = LocalStorage.getFavProductID();
    if (dataList.contains(widget.productListModel.id)) {
      isFav = true;
    }
    if (mounted) setState(() {});
  }

  void addRemoveFromList(
    int id,
    bool status,
  ) {
    var dataList = LocalStorage.getFavProductID();
    if (status) {
      dataList.remove(id);
      isFav = false;
    } else {
      dataList.add(id);
      isFav = true;
    }
    LocalStorage.setFavProductID(dataList);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ProductDetailsWidget(
      data: widget.productListModel,
      addRemoveFromList: addRemoveFromList,
      isFav: isFav,
    );
  }
}
