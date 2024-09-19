import 'package:freezed_annotation/freezed_annotation.dart';

import 'rating.dart';

part 'product_list_model.freezed.dart';
part 'product_list_model.g.dart';

@freezed
class ProductListModel with _$ProductListModel {
  factory ProductListModel({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) = _ProductListModel;

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductListModelFromJson(json);
}
