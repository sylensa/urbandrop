// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? status;
  List<ProductData>? data;
  String? message;

  ProductModel({
    this.status,
    this.data,
    this.message,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<ProductData>.from(json["data"]!.map((x) => ProductData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class ProductData {
  String? id;
  String? merchantId;
  String? categoryId;
  String? imageUrl;
  String? productName;
  String? productDescription;
  int? price;
  int? stock;
  String? unit;
  bool? inPromo;
  String? promoExpiry;

  ProductData({
    this.id,
    this.merchantId,
    this.categoryId,
    this.imageUrl,
    this.productName,
    this.productDescription,
    this.price,
    this.stock,
    this.unit,
    this.inPromo,
    this.promoExpiry,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"],
    merchantId: json["merchant_id"],
    categoryId: json["category_id"],
    imageUrl: json["image_url"],
    productName: json["product_name"],
    productDescription: json["product_description"],
    price: json["price"],
    stock: json["stock"],
    unit: json["unit"],
    inPromo: json["in_promo"],
    promoExpiry: json["promo_expiry"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "category_id": categoryId,
    "image_url": imageUrl,
    "product_name": productName,
    "product_description": productDescription,
    "price": price,
    "stock": stock,
    "unit": unit,
    "in_promo": inPromo,
    "promo_expiry": promoExpiry,
  };
}
