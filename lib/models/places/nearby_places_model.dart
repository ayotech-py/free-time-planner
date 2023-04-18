// To parse this JSON? data, do
//
//     final nearbyPlaces = nearbyPlacesFromMap(json?String);

import 'dart:convert';

NearbyPlaces nearbyPlacesFromMap(String str) =>
    NearbyPlaces.fromMap(json.decode(str));

String nearbyPlacesToMap(NearbyPlaces data) => json.encode(data.toMap());

class NearbyPlaces {
  NearbyPlaces({
    this.businessStatus,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.types,
  });

  String? businessStatus;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  List<dynamic>? photos;
  String? placeId;
  PlusCode? plusCode;
  double? rating;
  String? reference;
  List<String>? types;

  factory NearbyPlaces.fromMap(Map<String, dynamic>? json) => NearbyPlaces(
        businessStatus: json?["business_status"],
        formattedAddress: json?["formatted_address"],
        geometry: Geometry.fromMap(json?["geometry"]),
        icon: json?["icon"],
        iconBackgroundColor: json?["icon_background_color"],
        iconMaskBaseUri: json?["icon_mask_base_uri"],
        name: json?["name"],
        openingHours: OpeningHours.fromMap(json?["opening_hours"]),
        photos: List<dynamic>.from(json?["photos"].map((x) => x)),
        placeId: json?["place_id"],
        plusCode: PlusCode.fromMap(json?["plus_code"]),
        reference: json?["reference"],
        types: List<String>.from(json?["types"].map((x) => x)),
        rating: double.parse(json!["rating"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "business_status": businessStatus,
        "formatted_address": formattedAddress,
        "geometry": geometry?.toMap(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours?.toMap(),
        "photos": List<dynamic>.from(photos!.map((x) => x)),
        "place_id": placeId,
        "plus_code": plusCode?.toMap(),
        "rating": rating,
        "reference": reference,
        "types": List<dynamic>.from(types!.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromMap(Map<String, dynamic>? json) => Geometry(
        location: Location.fromMap(json?["location"]),
        viewport: Viewport.fromMap(json?["viewport"]),
      );

  Map<String, dynamic> toMap() => {
        "location": location?.toMap(),
        "viewport": viewport?.toMap(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromMap(Map<String, dynamic>? json) => Location(
        lat: json?["lat"]?.toDouble(),
        lng: json?["lng"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromMap(Map<String, dynamic>? json) => Viewport(
        northeast: Location.fromMap(json?["northeast"]),
        southwest: Location.fromMap(json?["southwest"]),
      );

  Map<String, dynamic> toMap() => {
        "northeast": northeast?.toMap(),
        "southwest": southwest?.toMap(),
      };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool? openNow;

  factory OpeningHours.fromMap(Map<String, dynamic>? json) => OpeningHours(
        openNow: json?["open_now"],
      );

  Map<String, dynamic> toMap() => {
        "open_now": openNow,
      };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromMap(Map<String, dynamic>? json) => PlusCode(
        compoundCode: json?["compound_code"],
        globalCode: json?["global_code"],
      );

  Map<String, dynamic> toMap() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}
