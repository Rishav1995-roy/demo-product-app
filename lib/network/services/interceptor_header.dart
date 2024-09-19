import 'dart:async';

import 'package:http_interceptor/http_interceptor.dart';

//interceptor header for services will be mentioned here.
class InterceptorHeader implements InterceptorContract {
  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    request.headers['content-type'] = 'application/json';
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }
}
