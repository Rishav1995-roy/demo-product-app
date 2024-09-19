import 'package:product_app/network/model/base_model/base_response_model.dart';
import 'package:product_app/network/model/base_model/error_response_model.dart';
import 'package:product_app/network/model/base_model/result_model.dart';
import 'package:product_app/network/services/headers.dart';
import 'package:product_app/network/services/http_client.dart';
import 'package:product_app/resource/strings.dart';

class ProductServices {
  final HttpClient _httpClient;

  ProductServices(this._httpClient);

  Future<Result> fetchProductList({
    required String url,
    required RequestMethod requestMethod,
    required Function(SuccessState data) parser,
  }) async {
    try {
      final responseRaw = await _httpClient.request(
        relativeURL: url,
        requestMethod: requestMethod,
        headers: Headers.getNonAuthenticationHeader(),
      );
      if (responseRaw is SuccessState) {
        ProductBaseResponse baseResponse =
            (parser(responseRaw) as SuccessState).baseResponse;
        return Result.success(baseResponse);
      } else if (responseRaw is ErrorState) {
        return Result.error(responseRaw.errorBody);
      } else {
        return Result.error(ErrorBody(message: Strings.bestFolks));
      }
    } catch (e) {
      return Result.error(ErrorBody(message: Strings.bestFolks));
    }
  }

}
