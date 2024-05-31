// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/models/product_model.dart';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  String? status;
  List<OrderData>? data;
  String? message;

  OrdersModel({
    this.status,
    this.data,
    this.message,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<OrderData>.from(json["data"]!.map((x) => OrderData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class OrderData {
  String? id;
  String? merchantId;
  String? customerId;
  String? riderId;
  String? status;
  var total;
  List<OrderProduct>? items;
  bool? riderAssigned;
  bool? completed;
  String? completedAt;
  String? createdAt;

  OrderData({
    this.id,
    this.merchantId,
    this.customerId,
    this.riderId,
    this.status,
    this.total,
    this.items,
    this.riderAssigned,
    this.completed,
    this.completedAt,
    this.createdAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    merchantId: json["merchant_id"],
    customerId: json["customer_id"],
    riderId: json["rider_id"],
    // status: "pending",
    status: json["status"],
    total: json["total"],
    items: json["items"] == null ? [] : List<OrderProduct>.from(json["items"]!.map((x) => OrderProduct.fromJson(x))),
    riderAssigned: json["rider_assigned"] == 1 ? true : false,
    completed: json["completed"]  == 1 ? true : false,
    completedAt: json["completed_at"] != null  ? DateTime.parse(json["completed_at"]).toString() : "",
    createdAt: json["created_at"] != null  ? DateTime.parse(json["created_at"]).toString() : "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "customer_id": customerId,
    "rider_id": riderId,
    "status": status,
    "total": total,
    "items": items == null ? [] : List<ProductData>.from(items!.map((x) => x.toJson())),
    "rider_assigned": riderAssigned,
    "completed": completed,
    "completed_at": completedAt,
    "created_at": createdAt,
  };
}

class OrderProduct {
  String? product_id;
  String? product_name;
  String? product_image;
  var price;
  int? quantity;
  int? total;


  OrderProduct({
    this.product_id,
    this.product_name,
    this.product_image,
    this.price,
    this.quantity,
    this.total,

  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    product_id: json["product_id"],
    product_name: json["product_name"],
    product_image: json["product_image"],
    price: json["price"],
    quantity: json["quantity"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": product_id,
    "product_name": product_name,
    "product_image": product_image,
    "price": price,
    "quantity": quantity,
    "total": total,

  };
}




