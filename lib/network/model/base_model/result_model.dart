import 'package:product_app/network/model/base_model/base_response_model.dart';
import 'package:product_app/network/model/base_model/error_response_model.dart';

class Result<T> {
  Result._();

  factory Result.loading(T msg) = LoadingState<T>;

  factory Result.success(ProductBaseResponse value) = SuccessState<T>;

  factory Result.error(ErrorBody msg) = ErrorState<T>;
}

class LoadingState<T> extends Result<T> {
  LoadingState(this.msg) : super._();
  final T msg;
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.errorBody) : super._();
  final ErrorBody errorBody;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.baseResponse) : super._();
  final ProductBaseResponse baseResponse;
}
