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
  String? promoName;
  String? promoDescription;
  int? promoAmount;
  int? promoPercentage;
  DateTime? promoStart;
  DateTime? promoExpiry;
  DateTime? createdAt;

  PromotionsData({
    this.id,
    this.imageUrl,
    this.promoName,
    this.promoDescription,
    this.promoAmount,
    this.promoPercentage,
    this.promoStart,
    this.promoExpiry,
    this.createdAt,
  });

  factory PromotionsData.fromJson(Map<String, dynamic> json) => PromotionsData(
    id: json["id"],
    imageUrl: json["image_url"],
    promoName: json["promo_name"],
    promoDescription: json["promo_description"],
    promoAmount: json["promo_amount"],
    promoPercentage: json["promo_percentage"],
    promoStart: json["promo_start"] == null ? null : DateTime.parse(json["promo_start"]),
    promoExpiry: json["promo_expiry"] == null ? null : DateTime.parse(json["promo_expiry"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "promo_name": promoName,
    "promo_description": promoDescription,
    "promo_amount": promoAmount,
    "promo_percentage": promoPercentage,
    "promo_start": promoStart?.toIso8601String(),
    "promo_expiry": promoExpiry?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  };
}
