part of 'product_list_screen_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListScreenInitial extends ProductListState {
  @override
  List<Object> get props => [];
}

// fetch product list
class FetchProductListInitial extends ProductListState {
  const FetchProductListInitial();
}

class FetchProductListFailure extends ProductListState {
  final String message;

  const FetchProductListFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchProductListSuccess extends ProductListState {
  final List<ProductListModel> productListModel;

  const FetchProductListSuccess({required this.productListModel});

  @override
  List<Object> get props => [productListModel];
}