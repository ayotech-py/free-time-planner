// To parse this JSON? data, do
//
// final placeUserModel = placeUserModelFromMap(json?String);

import 'dart:convert';

PlaceUserModel placeUserModelFromMap(String str) =>
    PlaceUserModel.fromMap(json.decode(str));

String placeUserModelToMap(PlaceUserModel data) => json.encode(data.toMap());

class PlaceUserModel {
  PlaceUserModel(
      {required this.businessStatus,
      required this.attractionAddress,
      required this.attractionName,
      required this.ratings,
      required this.latitude,
      required this.longitude,
      required this.attractionTypes,
      required this.about,
      required this.country,
      required this.openNow,
      required this.price});

  String? businessStatus;
  String? attractionAddress;
  String? attractionName;
  String? attractionTypes;
  double? latitude;
  double? ratings;
  String? about;
  double? longitude;
  bool? openNow;
  int? price;
  String? country;

  factory PlaceUserModel.fromMap(Map<String, dynamic>? json) => PlaceUserModel(
        businessStatus: json?["business_status"],
        attractionAddress: json?["location"],
        attractionName: json?["tourist_place"],
        attractionTypes: json?["types"],
        latitude: json?["lat"],
        longitude: json?["long"],
        about: json?["about"],
        ratings: json?["ratings"],
        openNow: json?["opening_now"],
        country: json?["country"],
        price: json?["price"],
      );

  Map<String, dynamic> toMap() => {
        "business_status": businessStatus,
        "attraction_address": attractionAddress,
        "attraction_name": attractionName,
        "ratings": ratings,
        "attraction_types": attractionTypes,
        "latitude": latitude,
        "longitude": longitude,
        "about": about,
        "country": country,
        "price": price,
        "open_now": openNow
      };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromMap(Map<String, dynamic>? json) => Geometry(
        location: Location.fromMap(json?["location"]),
        viewport: Viewport.fromMap(json?["viewport"]),
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "viewport": viewport.toMap(),
      };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Location.fromMap(Map<String, dynamic>? json) => Location(
        lat: 23.7632,
        lng: -123.1232,
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
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

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
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

class UserReview {
  UserReview({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.originalLanguage,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
    required this.translated,
  });

  String? authorName;
  String? authorUrl;
  String? language;
  String? originalLanguage;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;
  bool? translated;

  factory UserReview.fromMap(Map<String, dynamic>? json) => UserReview(
        authorName: json?["author_name"],
        authorUrl: json?["author_url"],
        language: json?["language"],
        originalLanguage: json?["original_language"],
        profilePhotoUrl: json?["profile_photo_url"],
        rating: json?["rating"],
        relativeTimeDescription: json?["relative_time_description"],
        text: json?["text"],
        time: json?["time"],
        translated: json?["translated"],
      );

  Map<String, dynamic> toMap() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "original_language": originalLanguage,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
        "translated": translated,
      };
}

class WeekdayText {
  WeekdayText({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  bool? openNow;
  List<Period>? periods;
  List<String>? weekdayText;

  factory WeekdayText.fromMap(Map<String, dynamic>? json) => WeekdayText(
        openNow: json?["open_now"],
        periods: json?["periods"] != null
            ? List<Period>.from(json?["periods"].map((x) => Period.fromMap(x)))
            : [],
        weekdayText: json?["weekday_text"] != null
            ? List<String>.from(json?["weekday_text"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "open_now": openNow,
        "periods": List<dynamic>.from(periods!.map((x) => x.toMap())),
        "weekday_text": List<dynamic>.from(weekdayText!.map((x) => x)),
      };
}

class Period {
  Period({
    required this.close,
    required this.open,
  });

  Close? close;
  Close? open;

  factory Period.fromMap(Map<String, dynamic>? json) => Period(
        close: Close.fromMap(json?["close"]),
        open: Close.fromMap(json?["open"]),
      );

  Map<String, dynamic> toMap() => {
        "close": close?.toMap(),
        "open": open?.toMap(),
      };
}

class Close {
  Close({
    required this.date,
    required this.day,
    required this.time,
    required this.truncated,
  });

  DateTime? date;
  int? day;
  String? time;
  bool? truncated;

  factory Close.fromMap(Map<String, dynamic>? json) => Close(
        date: DateTime.parse(json?["date"]),
        day: json?["day"],
        time: json?["time"],
        truncated: json?["truncated"],
      );

  Map<String, dynamic> toMap() => {
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "day": day,
        "time": time,
        "truncated": truncated,
      };
}
