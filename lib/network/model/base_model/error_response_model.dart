import 'dart:convert';

/// code : 900
/// sub-code : 907
/// message : "Invalid authentication token."

ErrorBody bloomazzErrorBodyFromJson(String str) =>
    ErrorBody.fromJson(json.decode(str));

String bloomazzErrorBodyToJson(ErrorBody data) => json.encode(data.toJson());

class ErrorBody {
  ErrorBody({
    num code = 0,
    num subcode = 0,
    String? message,
  }) {
    _code = code;
    _subcode = subcode;
    _message = message;
  }

  ErrorBody.fromJson(dynamic json) {
    _code = json['code'] ?? 0;
    _subcode = json['sub-code'] ?? 0;
    _message = json['message'] ?? "";
  }

  num _code = 0;
  num _subcode = 0;
  String? _message;

  ErrorBody copyWith({
    num? code,
    num? subcode,
    String? message,
  }) =>
      ErrorBody(
        code: code ?? _code,
        subcode: subcode ?? _subcode,
        message: message ?? _message,
      );

  num get code => _code;

  num get subcode => _subcode;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['sub-code'] = _subcode;
    map['message'] = _message;
    return map;
  }
}
