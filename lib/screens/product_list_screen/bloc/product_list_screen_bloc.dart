import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/network/model/base_model/result_model.dart';
import 'package:product_app/network/model/product_list_model/product_list_model.dart';
import 'package:product_app/network/repository/product_repository.dart';
import 'package:product_app/resource/strings.dart';

part 'product_list_screen_event.dart';
part 'product_list_screen_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  late final ProductRepository _productRepository;

  ProductListBloc({
    required ProductRepository productRepository,
  }) : super(ProductListScreenInitial()) {
    _productRepository = productRepository;

    on<FetchProductListEvent>(fetchProducts);
  }

  Future<void> fetchProducts(
    FetchProductListEvent event,
    Emitter emit,
  ) async {
    emit(const FetchProductListInitial());
    await _productRepository.fetchProductList().then((result) {
      if (result is SuccessState) {
        emit(
          FetchProductListSuccess(
            productListModel:
                result.baseResponse.data as List<ProductListModel>,
          ),
        );
      } else if (result is ErrorState) {
        emit(
          FetchProductListFailure(
            message: result.errorBody.message ?? Strings.bestFolks,
          ),
        );
      } else {
        emit(const FetchProductListFailure(message: Strings.bestFolks));
      }
    });
  }
}
