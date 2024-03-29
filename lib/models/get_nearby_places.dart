// To parse this JSON data, do
//
//     final getNearByPlaces = getNearByPlacesFromJson(jsonString);

import 'dart:convert';

GetNearByPlaces getNearByPlacesFromJson(String? str) => GetNearByPlaces.fromJson(json.decode(str!));

String? getNearByPlacesToJson(GetNearByPlaces data) => json.encode(data.toJson());

class GetNearByPlaces {
  GetNearByPlaces({
    this.plusCode,
    this.results,
    this.status,
  });

  PlusCode? plusCode;
  List<Result>? results;
  String? status;

  factory GetNearByPlaces.fromJson(Map<String, dynamic> json) => GetNearByPlaces(
    plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "plus_code": plusCode == null ? null : plusCode!.toJson(),
    "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"] == null ? null : json["compound_code"],
    globalCode: json["global_code"] == null ? null : json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode == null ? null : compoundCode,
    "global_code": globalCode == null ? null : globalCode,
  };
}

class Result {
  Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
    this.plusCode,
    this.name,
  });

  List<AddressComponent>? addressComponents;
  String? formattedAddress;
  String? name;
  Geometry? geometry;
  String? placeId;
  List<String>? types;
  PlusCode? plusCode;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    addressComponents: json["address_components"] == null ? null : List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
    formattedAddress: json["formatted_address"] == null ? null : json["formatted_address"],
    name: json["name"] == null ? null : json["name"],
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    placeId: json["place_id"] == null ? null : json["place_id"],
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
    plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
  );

  Map<String, dynamic> toJson() => {
    "address_components": addressComponents == null ? null : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
    "formatted_address": formattedAddress == null ? null : formattedAddress,
    "name": name == null ? null : name,
    "geometry": geometry == null ? null : geometry!.toJson(),
    "place_id": placeId == null ? null : placeId,
    "types": types == null ? null : List<dynamic>.from(types!.map((x) => x)),
    "plus_code": plusCode == null ? null : plusCode!.toJson(),
  };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
    longName: json["long_name"] == null ? null : json["long_name"],
    shortName: json["short_name"] == null ? null : json["short_name"],
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "long_name": longName == null ? null : longName,
    "short_name": shortName == null ? null : shortName,
    "types": types == null ? null : List<dynamic>.from(types!.map((x) => x)),
  };
}

class Geometry {
  Geometry({
    this.bounds,
    this.location,
    this.locationType,
    this.viewport,
  });

  Bounds? bounds;
  Location? location;
  String? locationType;
  Bounds? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    locationType: json["location_type"] == null ? null : json["location_type"],
    viewport: json["viewport"] == null ? null : Bounds.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "bounds": bounds == null ? null : bounds!.toJson(),
    "location": location == null ? null : location!.toJson(),
    "location_type": locationType == null ? null : locationType,
    "viewport": viewport == null ? null : viewport!.toJson(),
  };
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    northeast: json["northeast"] == null ? null : Location.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast == null ? null : northeast!.toJson(),
    "southwest": southwest == null ? null : southwest!.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}
