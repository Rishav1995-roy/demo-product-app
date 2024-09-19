// ignore_for_file: unnecessary_getters_setters

class ProductBaseResponse<T> {
  ProductBaseResponse({
    T? data,
  }) {
    _data = data;
  }

  ProductBaseResponse.fromJson(dynamic json) {
    _data = json ?? [];
  }

  T? _data;

  T? get data => _data;

  set data(T? value) {
    _data = value;
  }
}
