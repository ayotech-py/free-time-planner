// To parse this JSON? data, do
//
//     final placeModel = placeModelFromMap(json?String);

import 'dart:convert';

PlaceModel placeModelFromMap(String str) =>
    PlaceModel.fromMap(json.decode(str));

String placeModelToMap(PlaceModel data) => json.encode(data.toMap());

class PlaceModel {
  PlaceModel({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory PlaceModel.fromMap(Map<String, dynamic>? json) => PlaceModel(
        data: Data.fromMap(json?["data"]),
        message: json?["message"],
        success: json?["success"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
        "success": success,
      };
}

class Data {
  Data({
    this.place,
  });

  Place? place;

  factory Data.fromMap(Map<String, dynamic>? json) => Data(
        place: Place.fromMap(json?["place"]),
      );

  Map<String, dynamic> toMap() => {
        "place": place?.toMap(),
      };
}

class Place {
  Place({
    //this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.curbsidePickup,
    this.currentOpeningHours,
    this.delivery,
    this.dineIn,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    //this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reservable,
    //this.reviews,
    this.servesBeer,
    this.servesBreakfast,
    this.servesBrunch,
    this.servesDinner,
    this.servesLunch,
    this.servesWine,
    this.takeout,
    //this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
  });

  //List<AddressComponent>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  bool? curbsidePickup;
  CurrentOpeningHours? currentOpeningHours;
  bool? delivery;
  bool? dineIn;
  String? formattedAddress;
  String? formattedPhoneNumber;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? internationalPhoneNumber;
  String? name;
  OpeningHours? openingHours;
  //List<Photo>? photos;
  String? placeId;
  PlusCode? plusCode;
  double? rating;
  String? reference;
  bool? reservable;
  //List<Review>? reviews;
  bool? servesBeer;
  bool? servesBreakfast;
  bool? servesBrunch;
  bool? servesDinner;
  bool? servesLunch;
  bool? servesWine;
  bool? takeout;
  //List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;

  factory Place.fromMap(Map<String, dynamic>? json) => Place(
        //addressComponents: List<AddressComponent>.from(json?["address_components"].map((x) => AddressComponent.fromMap(x))),
        adrAddress: json?["adr_address"],
        businessStatus: json?["business_status"],
        curbsidePickup: json?["curbside_pickup"],
        currentOpeningHours:
            CurrentOpeningHours.fromMap(json?["current_opening_hours"]),
        delivery: json?["delivery"],
        dineIn: json?["dine_in"],
        formattedAddress: json?["formatted_address"],
        formattedPhoneNumber: json?["formatted_phone_number"],
        geometry: Geometry.fromMap(json?["geometry"]),
        icon: json?["icon"],
        iconBackgroundColor: json?["icon_background_color"],
        iconMaskBaseUri: json?["icon_mask_base_uri"],
        internationalPhoneNumber: json?["international_phone_number"],
        name: json?["name"],
        openingHours: OpeningHours.fromMap(json?["opening_hours"]),
        //photos: List<Photo>.from(json?["photos"].map((x) => Photo.fromMap(x))),
        placeId: json?["place_id"],
        plusCode: PlusCode.fromMap(json?["plus_code"]),
        rating: json?["rating"]?.toDouble(),
        reference: json?["reference"],
        reservable: json?["reservable"],
        //reviews:List<Review>.from(json?["reviews"].map((x) => Review.fromMap(x))),
        servesBeer: json?["serves_beer"],
        servesBreakfast: json?["serves_breakfast"],
        servesBrunch: json?["serves_brunch"],
        servesDinner: json?["serves_dinner"],
        servesLunch: json?["serves_lunch"],
        servesWine: json?["serves_wine"],
        takeout: json?["takeout"],
        //types: List<String>.from(json?["types"].map((x) => x)),
        url: json?["url"],
        userRatingsTotal: json?["user_ratings_total"],
        utcOffset: json?["utc_offset"],
        vicinity: json?["vicinity"],
      );

  Map<String, dynamic> toMap() => {
        //"address_components":List<dynamic>.from(addressComponents!.map((x) => x.toMap())),
        "adr_address": adrAddress,
        "business_status": businessStatus,
        "curbside_pickup": curbsidePickup,
        "current_opening_hours": currentOpeningHours?.toMap(),
        "delivery": delivery,
        "dine_in": dineIn,
        "formatted_address": formattedAddress,
        "formatted_phone_number": formattedPhoneNumber,
        "geometry": geometry?.toMap(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "international_phone_number": internationalPhoneNumber,
        "name": name,
        "opening_hours": openingHours?.toMap(),
        //"photos": List<dynamic>.from(photos!.map((x) => x.toMap())),
        "place_id": placeId,
        "plus_code": plusCode?.toMap(),
        "rating": rating,
        "reference": reference,
        "reservable": reservable,
        // "reviews": List<dynamic>.from(reviews!.map((x) => x.toMap())),
        "serves_beer": servesBeer,
        "serves_breakfast": servesBreakfast,
        "serves_brunch": servesBrunch,
        "serves_dinner": servesDinner,
        "serves_lunch": servesLunch,
        "serves_wine": servesWine,
        "takeout": takeout,
        //"types": List<dynamic>.from(types!.map((x) => x)),
        "url": url,
        "user_ratings_total": userRatingsTotal,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
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

  factory AddressComponent.fromMap(Map<String, dynamic>? json) =>
      AddressComponent(
        longName: json?["long_name"],
        shortName: json?["short_name"],
        types: List<String>.from(json?["types"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types!.map((x) => x)),
      };
}

class CurrentOpeningHours {
  CurrentOpeningHours({
    this.openNow,
    //this.periods,
    //this.weekdayText,
  });

  bool? openNow;
  //List<CurrentOpeningHoursPeriod>? periods;
  //List<String>? weekdayText;

  factory CurrentOpeningHours.fromMap(Map<String, dynamic>? json) =>
      CurrentOpeningHours(
        openNow: json?["open_now"],
        // periods: List<CurrentOpeningHoursPeriod>.from(json?["periods"].map((x) => CurrentOpeningHoursPeriod.fromMap(x))),
        // weekdayText: List<String>.from(json?["weekday_text"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "open_now": openNow,
        //"periods": List<dynamic>.from(periods!.map((x) => x.toMap())),
        //"weekday_text": List<dynamic>.from(weekdayText!.map((x) => x)),
      };
}

class CurrentOpeningHoursPeriod {
  CurrentOpeningHoursPeriod({
    this.close,
    this.open,
  });

  Close? close;
  Close? open;

  factory CurrentOpeningHoursPeriod.fromMap(Map<String, dynamic>? json) =>
      CurrentOpeningHoursPeriod(
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
    this.date,
    this.day,
    this.time,
    this.truncated,
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
    //this.periods,
    //this.weekdayText,
  });

  bool? openNow;
  //List<OpeningHoursPeriod>? periods;
  //List<String>? weekdayText;

  factory OpeningHours.fromMap(Map<String, dynamic>? json) => OpeningHours(
        openNow: json?["open_now"],
        //periods: List<OpeningHoursPeriod>.from(json?["periods"].map((x) => OpeningHoursPeriod.fromMap(x))),
        //weekdayText: List<String>.from(json?["weekday_text"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "open_now": openNow,
        // "periods": List<dynamic>.from(periods!.map((x) => x.toMap())),
        // "weekday_text": List<dynamic>.from(weekdayText!.map((x) => x)),
      };
}

class OpeningHoursPeriod {
  OpeningHoursPeriod({
    this.open,
  });

  Open? open;

  factory OpeningHoursPeriod.fromMap(Map<String, dynamic>? json) =>
      OpeningHoursPeriod(
        open: Open.fromMap(json?["open"]),
      );

  Map<String, dynamic> toMap() => {
        "open": open!.toMap(),
      };
}

class Open {
  Open({
    this.day,
    this.time,
  });

  int? day;
  String? time;

  factory Open.fromMap(Map<String, dynamic>? json) => Open(
        day: json?["day"],
        time: json?["time"],
      );

  Map<String, dynamic> toMap() => {
        "day": day,
        "time": time,
      };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromMap(Map<String, dynamic>? json) => Photo(
        height: json?["height"],
        htmlAttributions:
            List<String>.from(json?["html_attributions"].map((x) => x)),
        photoReference: json?["photo_reference"],
        width: json?["width"],
      );

  Map<String, dynamic> toMap() => {
        "height": height,
        "html_attributions":
            List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
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

class Review {
  Review({
    this.authorName,
    this.authorUrl,
    this.language,
    this.originalLanguage,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
    this.translated,
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

  factory Review.fromMap(Map<String, dynamic>? json) => Review(
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
