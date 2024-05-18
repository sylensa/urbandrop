// To parse this JSON data, do
//
//     final orderSummaryModel = orderSummaryModelFromJson(jsonString);

import 'dart:convert';

OrderSummaryModel orderSummaryModelFromJson(String str) => OrderSummaryModel.fromJson(json.decode(str));

String orderSummaryModelToJson(OrderSummaryModel data) => json.encode(data.toJson());

class OrderSummaryModel {
  String? status;
  OrderSummary? data;
  String? message;

  OrderSummaryModel({
    this.status,
    this.data,
    this.message,
  });

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) => OrderSummaryModel(
    status: json["status"],
    data: json["data"] == null ? null : OrderSummary.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class OrderSummary {
  int? count;
  int? revenue;
  int? deliveries;

  OrderSummary({
    this.count,
    this.revenue,
    this.deliveries,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
    count: json["count"],
    revenue: json["revenue"],
    deliveries: json["deliveries"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "revenue": revenue,
    "deliveries": deliveries,
  };
}
