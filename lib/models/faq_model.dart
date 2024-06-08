
import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  String? status;
  List<FaqData>? data;
  String? message;

  FaqModel({
    this.status,
    this.data,
    this.message,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<FaqData>.from(json["data"]!.map((x) => FaqData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class FaqData {
  String? question;
  String? answer;

  FaqData({
    this.question,
    this.answer,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) => FaqData(
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}
