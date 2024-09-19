import 'package:product_app/network/model/base_model/result_model.dart';
import 'package:product_app/network/model/product_list_model/product_list_model.dart';
import 'package:product_app/network/services/end_points_service.dart';
import 'package:product_app/network/services/http_client.dart';
import 'package:product_app/network/services/product_services.dart';

class ProductRepository {
  final ProductServices _productDetailServices;

  ProductRepository(this._productDetailServices);

  Future<Result> fetchProductList() async {
    return _productDetailServices.fetchProductList(
      url: EndPointsService.fetchProductListAPI,
      requestMethod: RequestMethod.GET,
      parser: (SuccessState responseRaw) {
        List<ProductListModel> productDetailsModel =
            List<ProductListModel>.from(responseRaw.baseResponse.data
                .map((e) => ProductListModel.fromJson(e)));
        responseRaw.baseResponse.data = productDetailsModel;
        return responseRaw;
      },
    );
  }

}
