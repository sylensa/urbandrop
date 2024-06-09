// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  List<MerchantCategory>? merchantCategories;
  List<ProductCategory>? productCategories;
  List<DeactivationReason>? deactivationReasons;

  ConfigModel({
    this.merchantCategories,
    this.productCategories,
    this.deactivationReasons,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    merchantCategories: json["merchant_categories"] == null ? [] : List<MerchantCategory>.from(json["merchant_categories"]!.map((x) => MerchantCategory.fromJson(x))),
    productCategories: json["product_categories"] == null ? [] : List<ProductCategory>.from(json["product_categories"]!.map((x) => ProductCategory.fromJson(x))),
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

class MerchantCategory {
  String? id;
  String? name;

  MerchantCategory({
    this.id,
    this.name,
  });

  factory MerchantCategory.fromJson(Map<String, dynamic> json) => MerchantCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class ProductCategory {
  String? id;
  String? categoryName;
  String? imageUrl;

  ProductCategory({
    this.id,
    this.categoryName,
    this.imageUrl,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    categoryName: json["category_name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "image_url": imageUrl,
  };
}
