// To parse this JSON data, do
//
//     final getPredictions = getPredictionsFromJson(jsonString);

import 'dart:convert';

GetPredictions getPredictionsFromJson(String str) => GetPredictions.fromJson(json.decode(str));

String getPredictionsToJson(GetPredictions data) => json.encode(data.toJson());

class GetPredictions {
  GetPredictions({
    this.predictions,
    this.status,
  });

  List<Prediction>? predictions;
  String? status;

  factory GetPredictions.fromJson(Map<String, dynamic> json) => GetPredictions(
    predictions: json["predictions"] == null ? null : List<Prediction>.from(json["predictions"].map((x) => Prediction.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "predictions": predictions == null ? null : List<dynamic>.from(predictions!.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class Prediction {
  Prediction({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  String? description;
  List<MatchedSubstring>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Term>? terms;
  List<Type>? types;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    description: json["description"] == null ? null : json["description"],
    matchedSubstrings: json["matched_substrings"] == null ? null : List<MatchedSubstring>.from(json["matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
    placeId: json["place_id"] == null ? null : json["place_id"],
    reference: json["reference"] == null ? null : json["reference"],
    structuredFormatting: json["structured_formatting"] == null ? null : StructuredFormatting.fromJson(json["structured_formatting"]),
    terms: json["terms"] == null ? null : List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "description": description == null ? null : description,
    "matched_substrings": matchedSubstrings == null ? null : List<dynamic>.from(matchedSubstrings!.map((x) => x.toJson())),
    "place_id": placeId == null ? null : placeId,
    "reference": reference == null ? null : reference,
    "structured_formatting": structuredFormatting == null ? null : structuredFormatting!.toJson(),
    "terms": terms == null ? null : List<dynamic>.from(terms!.map((x) => x.toJson())),
    "types": types == null ? null : List<dynamic>.from(types!.map((x) => typeValues.reverse[x])),
  };
}

class MatchedSubstring {
  MatchedSubstring({
    this.length,
    this.offset,
  });

  int? length;
  int? offset;

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) => MatchedSubstring(
    length: json["length"] == null ? null : json["length"],
    offset: json["offset"] == null ? null : json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "length": length == null ? null : length,
    "offset": offset == null ? null : offset,
  };
}

class StructuredFormatting {
  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  String? mainText;
  List<MatchedSubstring>? mainTextMatchedSubstrings;
  String? secondaryText;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) => StructuredFormatting(
    mainText: json["main_text"] == null ? null : json["main_text"],
    mainTextMatchedSubstrings: json["main_text_matched_substrings"] == null ? null : List<MatchedSubstring>.from(json["main_text_matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
    secondaryText: json["secondary_text"] == null ? null : json["secondary_text"],
  );

  Map<String, dynamic> toJson() => {
    "main_text": mainText == null ? null : mainText,
    "main_text_matched_substrings": mainTextMatchedSubstrings == null ? null : List<dynamic>.from(mainTextMatchedSubstrings!.map((x) => x.toJson())),
    "secondary_text": secondaryText == null ? null : secondaryText,
  };
}

class Term {
  Term({
    this.offset,
    this.value,
  });

  int? offset;
  String? value;

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    offset: json["offset"] == null ? null : json["offset"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "offset": offset == null ? null : offset,
    "value": value == null ? null : value,
  };
}

enum Type { STREET_ADDRESS, GEOCODE, ROUTE }

final typeValues = EnumValues({
  "geocode": Type.GEOCODE,
  "route": Type.ROUTE,
  "street_address": Type.STREET_ADDRESS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
