// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  String? status;
  ConfigData? data;
  String? message;

  ConfigModel({
    this.status,
    this.data,
    this.message,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    status: json["status"],
    data: json["data"] == null ? null : ConfigData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class ConfigData {
  List<TCategory>? merchantCategories;
  List<TCategory>? productCategories;
  List<DeactivationReason>? deactivationReasons;

  ConfigData({
    this.merchantCategories,
    this.productCategories,
    this.deactivationReasons,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
    merchantCategories: json["merchant_categories"] == null ? [] : List<TCategory>.from(json["merchant_categories"]!.map((x) => TCategory.fromJson(x))),
    productCategories: json["product_categories"] == null ? [] : List<TCategory>.from(json["product_categories"]!.map((x) => TCategory.fromJson(x))),
    deactivationReasons: json["deactivation_reasons"] == null ? [] : List<DeactivationReason>.from(json["deactivation_reasons"]!.map((x) => DeactivationReason.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "merchant_categories": merchantCategories == null ? [] : List<dynamic>.from(merchantCategories!.map((x) => x.toJson())),
    "product_categories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toJson())),
    "deactivation_reasons": deactivationReasons == null ? [] : List<dynamic>.from(deactivationReasons!.map((x) => x.toJson())),
  };
}

class DeactivationReason {
  String? id;
  String? reason;

  DeactivationReason({
    this.id,
    this.reason,
  });

  factory DeactivationReason.fromJson(Map<String, dynamic> json) => DeactivationReason(
    id: json["id"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
  };
}

class TCategory {
  String? id;
  String? categoryName;

  TCategory({
    this.id,
    this.categoryName,
  });

  factory TCategory.fromJson(Map<String, dynamic> json) => TCategory(
    id: json["id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
  };
}
