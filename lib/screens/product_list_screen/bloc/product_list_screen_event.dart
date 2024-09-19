part of 'product_list_screen_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class FetchProductListEvent extends ProductListEvent {
  const FetchProductListEvent();
  @override
  List<Object> get props => [];
}