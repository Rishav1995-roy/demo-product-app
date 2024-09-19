// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:product_app/locator.dart';
import 'package:product_app/network/model/base_model/base_response_model.dart';
import 'package:product_app/network/model/base_model/error_response_model.dart';
import 'package:product_app/network/model/base_model/result_model.dart';
import 'package:product_app/utils/context_extensions.dart';
import 'package:product_app/utils/connectivity_module.dart';
import 'package:product_app/resource/strings.dart';

enum RequestMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
  MULTIPART,
}

class HttpClient {
  final InterceptedClient _client;
  final _internalServerError = 500;
  final _successResponseCode = 200;
  final _acceptedResponseCode = 201;
  static const noInternetErrorCode = "no-internet";
  final String _headerContentType = 'Content-Type';
  final String _contentTypeJSON = 'application/json';
  final String _contentTypeXForm = 'application/x-www-form-urlencoded';
  final String _baseURL = 'https://fakestoreapi.com'; //base url

  HttpClient(this._client);

  Future<Result> request({
    required String relativeURL,
    required RequestMethod requestMethod,
    dynamic bodyData,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    String? filePath,
    String? multipartFilepathKeyName,
  }) async {
    bool networkActive = locator<InternetStatusController>().isOnline;

    if (!networkActive) {
      /// do all the operation which we need to do while there's no internet
      BuildContextExtensionFunctions.navigatorKey.currentState?.context
          .showToast(Strings.noInternetAlert);

      return Future.value(
        Result.error(
          ErrorBody(
            message: Strings.noInternetAlert,
            code: 111,
          ),
        ),
      );
    }
    String path = _baseURL + relativeURL;
    debugPrint("request - $path");
    var url = Uri.parse(path);
    if (queryParams != null) {
      url = url.replace(queryParameters: queryParams);
    }

    var header = headers ?? <String, String>{};

    Result result;

    switch (requestMethod) {
      case RequestMethod.GET:
        result = await _executeGet(url, header);
        break;
      case RequestMethod.POST:
        result = await _executePost(url, header, bodyData);
        break;
      case RequestMethod.PUT:
        result = await _executePut(url, header, bodyData);
        break;
      case RequestMethod.PATCH:
        result = await _executePatch(url, header, bodyData);
        break;
      case RequestMethod.DELETE:
        result = await _executeDelete(url, header, bodyData);
        break;
      case RequestMethod.MULTIPART:
        result = await _executeMultipart(
          url,
          header,
          bodyData,
          filePath,
          multipartFilepathKeyName,
        );
        break;
      default:
        return throw RequestTypeNotFoundException(
            Strings.requestNotFoundErrorMessage);
    }

    return result;
  }

  Future<Result> _executeGet(url, header) async {
    header[_headerContentType] = _contentTypeJSON;
    try {
      var response = await _client.get(url, headers: header);
      return _onResponse(response, url);
    } catch (error) {
      return Result.error(ErrorBody(message: "Error Occur: $error"));
    }
  }

  Future<Result> _executePost(url, header, parameter) async {
    var body = json.encode(parameter);
    header[_headerContentType] = _contentTypeJSON;
    try {
      var response = await _client.post(url, headers: header, body: body);
      return _onResponse(response, url, bodyData: parameter);
    } catch (error) {
      return Result.error(ErrorBody(message: "Error Occur: $error"));
    }
  }

  Future<Result> _executeMultipart(
    url,
    header,
    parameter,
    filePath,
    multipartFilepathKeyName,
  ) async {
    header[_headerContentType] = _contentTypeXForm;
    var request = http.MultipartRequest('POST', Uri.parse(url.toString()));
    request.headers.addAll(header);
    request.fields.addAll(parameter);
    if (filePath?.isNotEmpty) {
      var multipartFile = await http.MultipartFile.fromPath(
          multipartFilepathKeyName ?? "", filePath);
      request.files.add(multipartFile);
    }
    try {
      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      return _onResponse(response, url, bodyData: parameter);
    } catch (error) {
      return Result.error(ErrorBody(message: "Error Occur: $error"));
    }
  }

  Future<Result> _executePut(
    url,
    header,
    parameter,
  ) async {
    header[_headerContentType] = _contentTypeJSON;
    var body = json.encode(parameter);
    try {
      var response = await _client.put(url, headers: header, body: body);
      return _onResponse(response, url, bodyData: parameter);
    } catch (error) {
      return Result.error(ErrorBody(message: "Error Occur: $error"));
    }
  }

  Future<Result> _executePatch(
    url,
    header,
    parameter,
  ) async {
    header[_headerContentType] = _contentTypeJSON;
    var body = json.encode(parameter);
    try {
      var response = await _client.patch(url, headers: header, body: body);
      return _onResponse(response, url, bodyData: parameter);
    } catch (error) {
      return Result.error(ErrorBody(message: "Error Occur: $error"));
    }
  }

  Future<Result> _executeDelete(url, header, parameter) async {
    header[_headerContentType] = _contentTypeJSON;
    var body = json.encode(parameter);
    try {
      var response = await _client.delete(url, headers: header, body: body);
      return _onResponse(response, url, bodyData: parameter);
    } catch (error) {
      return Result.error(ErrorBody(message: "Error Occur: $error"));
    }
  }

  Future<Result> _onResponse(response, url, {Map? bodyData}) async {
    // debugPrint('On Response: $response');

    var httpResponseCode = response.statusCode;

    try {
      if (httpResponseCode == _successResponseCode ||
          httpResponseCode == _acceptedResponseCode) {
        ProductBaseResponse baseResponse = ProductBaseResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes).toString()));

        return Result.success(baseResponse);
      } else if (httpResponseCode == _internalServerError) {
        try {
          ErrorBody baseResponse =
              ErrorBody.fromJson(json.decode(response.body.toString()));
          return Result.error(baseResponse);
        } catch (e) {
          ErrorBody baseResponse = ErrorBody(
              code: 500, subcode: -1, message: Strings.bestFolks);
          return Result.error(baseResponse);
        }
      } else {
        ErrorBody baseResponse =
            ErrorBody.fromJson(json.decode(response.body.toString()));

        return Result.error(baseResponse);
      }
    } catch (e) {
      ErrorBody baseResponse =
          ErrorBody(code: 999, subcode: -1, message: Strings.bestFolks);
      return Result.error(baseResponse);
    }
  }
}

class RequestTypeNotFoundException implements Exception {
  String cause;

  RequestTypeNotFoundException(this.cause);
}

Future<bool> checkConnectionStatus() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    return true;
  } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  }
  return false;
}
