import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:free_time_planner/constants/app_api_config.dart';
import 'package:free_time_planner/models/places/nearby_places_model.dart';
import 'package:free_time_planner/models/places/place_model.dart';
import 'package:free_time_planner/models/places/place_user_model.dart';

typedef ResMap = Map<String, dynamic>;
typedef ResList = List<Map<String, dynamic>>;

class PlaceRepoImpl {
  final _dio = Dio();
  //final messageStream = StreamController<List<Message>>.broadcast();

  /*Future<List<Contacts>> getAllContacts(String token) async {
    _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.getAllContactMessages(),
    );

    final contacts = (res.data?['data'] as List);
    return contacts.map((e) => Contacts.fromMap(e)).toList();
  }*/

  Future<List<NearbyPlaces>> getAllPlaces({
    required String? lat,
    required String? long,
    required String type,
  }) async {
    //_dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.nearbyPlacesUri(
          lat: lat ?? '45.50884', long: long ?? '73.58781', type: type),
    );
    log(res.toString());
    final places = (res.data?['data']['places'] as List);
    log(places.toString());
    return places.map((e) => NearbyPlaces.fromMap(e)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.placeUri(placeId),
    );
    final places = (res.data?['data']['place']);
    print(places);
    return Place.fromMap(places);
  }

  Future<List<PlaceUserModel>> getNewPlaces({
    required double? lat,
    required double? long,
    required String type,
  }) async {
    final res = await _dio.postUri<ResMap>(
      //
      //'https://tourist-attraction-api.onrender.com/places/tourist_attraction',
      AppApiConfig.getbyType(),
      data: {"lng": long ?? 73.58781, "lat": lat ?? 45.50884, "type": type},
    );
    final places = (res.data?['data']['places'] as List);
    print(places);
    return places.map((e) => PlaceUserModel.fromMap(e)).toList();
  }
}
