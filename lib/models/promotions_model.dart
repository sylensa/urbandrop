// To parse this JSON data, do
//
//     final promotionsModel = promotionsModelFromJson(jsonString);

import 'dart:convert';

PromotionsModel promotionsModelFromJson(String str) => PromotionsModel.fromJson(json.decode(str));

String promotionsModelToJson(PromotionsModel data) => json.encode(data.toJson());

class PromotionsModel {
  String? status;
  List<PromotionsData>? data;
  String? message;

  PromotionsModel({
    this.status,
    this.data,
    this.message,
  });

  factory PromotionsModel.fromJson(Map<String, dynamic> json) => PromotionsModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<PromotionsData>.from(json["data"]!.map((x) => PromotionsData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class PromotionsData {
  String? id;
  String? imageUrl;
  String? promoCategory;
  String? minimum_sale;
  String? promoName;
  String? promoDescription;
  String? promoType;
  dynamic promoValue;
  List<String>? promoProducts;
  List<String>? promo_product_categories;
  DateTime? promoStart;
  DateTime? promoExpiry;
  DateTime? createdAt;

  PromotionsData({
    this.id,
    this.imageUrl,
    this.promoCategory,
    this.promoName,
    this.promoDescription,
    this.promoType,
    this.promoValue,
    this.promoProducts,
    this.promoStart,
    this.promoExpiry,
    this.createdAt,
    this.minimum_sale,
    this.promo_product_categories,
  });

  factory PromotionsData.fromJson(Map<String, dynamic> json) => PromotionsData(
    id: json["id"],
    imageUrl: json["image_url"],
    promoCategory: json["promo_category"],
    promoName: json["promo_name"],
    minimum_sale: json["minimum_sale"] ?? "",
    promoDescription: json["promo_description"],
    promoType: json["promo_type"],
    promoValue: json["promo_value"],
    promoProducts: json["promo_products"] == null ? [] : List<String>.from(json["promo_products"]!.map((x) => x)),
    promo_product_categories: json["promo_product_categories"] == null ? [] : List<String>.from(json["promo_product_categories"]!.map((x) => x)),
    promoStart: json["promo_start"] == null ? null : DateTime.parse(json["promo_start"]),
    promoExpiry: json["promo_expiry"] == null ? null : DateTime.parse(json["promo_expiry"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "promo_category": promoCategory,
    "promo_name": promoName,
    "promo_description": promoDescription,
    "promo_type": promoType,
    "promo_value": promoValue,
    "promo_products": promoProducts == null ? [] : List<dynamic>.from(promoProducts!.map((x) => x)),
    "promo_product_categories": promo_product_categories == null ? [] : List<dynamic>.from(promo_product_categories!.map((x) => x)),
    "promo_start": promoStart?.toIso8601String(),
    "promo_expiry": promoExpiry?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  };
}
