import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:product_app/network/model/product_list_model/product_list_model.dart';
import 'package:product_app/network/repository/product_repository.dart';
import 'package:product_app/screens/product_details_screen/screen/product_deatils_screen.dart';
import 'package:product_app/screens/product_list_screen/bloc/product_list_screen_bloc.dart';
import 'package:product_app/screens/product_list_screen/widget/product_list_widget.dart';
import 'package:product_app/utils/context_extensions.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static const String routeName = '/product-list-screen';

  static GoRoute route({
    required ProductRepository productRepository,
  }) {
    return GoRoute(
      name: 'product-list',
      path: ProductListScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (_) => ProductListBloc(
          productRepository: productRepository,
        ),
        child: const ProductListScreen(),
      ),
    );
  }

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductListModel> productList = [];
  List<ProductListModel> filterList = [];
  TextEditingController serachController = TextEditingController();
  late FocusNode focusNode;
  ScrollController listViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    context.afterWidgetBuilt(() {
      fetchProducts();
    });

    listViewController.addListener(() {
      if (listViewController.position.atEdge &&
          listViewController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        // here call the data with new page
      }
    });
  }

  void fetchProducts() {
    context.read<ProductListBloc>().add(const FetchProductListEvent());
  }

  void searchProducts() {
    filterList.clear();
    for (var item in productList) {
      if (item.title!.toLowerCase().contains(serachController.text.toLowerCase())) {
        filterList.add(item);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  void clickOnProduct(
    ProductListModel data,
  ) {
    context.push(ProductDetailsScreen.routeName, extra: data);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListBloc, ProductListState>(
      listener: (context, state) {
        if (state is FetchProductListInitial) {
          context.loaderOverlay.show();
        } else if (state is FetchProductListFailure) {
          context.loaderOverlay.hide();
          context.showFailureMessage(state.message);
        } else if (state is FetchProductListSuccess) {
          context.loaderOverlay.hide();
          productList = state.productListModel;
        }
      },
      builder: (context, state) {
        return ProductListWidget(
          productList:
              serachController.text.isNotEmpty ? filterList : productList,
          searchProducts: searchProducts,
          serachController: serachController,
          focusNode: focusNode,
          listViewController: listViewController,
          clickOnProduct: clickOnProduct,
        );
      },
    );
  }
}
