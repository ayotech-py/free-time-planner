import 'dart:async';

import 'package:dio/dio.dart';
import 'package:free_time_planner/constants/app_api_config.dart';
import 'package:free_time_planner/models/places/place_user_model.dart';

typedef ResMap = Map<String, dynamic>;
typedef ResList = List<Map<String, dynamic>>;

class PlaceRepoImpl {
  final _dio = Dio();

  Future<List<PlaceUserModel>> getNewPlaces({
    required double? lat,
    required double? long,
    required String type,
  }) async {
    final res = await _dio.postUri<ResMap>(
      //
      //'https://tourist-attraction-api.onrender.com/places/tourist_attraction',
      AppApiConfig.getbyType(),
      data: {
        "lng": long ?? -73.58781,
        "lat": lat ?? 45.50884,
        "type": type,
        'radius': 2000,
      },
    );
    final places = (res.data?['data']['places'] as List);
    print(places);
    return places.map((e) => PlaceUserModel.fromMap(e)).toList();
  }

  Future<List<PlaceUserModel>> getByKeyword({
    required double? lat,
    required double? long,
    required String type,
    required String keyword,
  }) async {
    final res = await _dio.postUri<ResMap>(
      //
      //'https://tourist-attraction-api.onrender.com/places/tourist_attraction',
      AppApiConfig.getbyKeyword(),
      data: {
        "lng": long ?? -73.58781,
        "lat": lat ?? 45.50884,
        "type": type,
        'radius': 8000,
        'keyword': keyword
      },
    );
    final places = (res.data?['data']['places'] as List);
    print(places);
    return places.map((e) => PlaceUserModel.fromMap(e)).toList();
  }

  Future<List<PlaceUserModel>> getByProvince({
    //required String type,
    required String keyword,
  }) async {
    final res = await _dio.postUri<ResMap>(
      //
      //'https://tourist-attraction-api.onrender.com/places/tourist_attraction',
      AppApiConfig.getbyProvince(),
      data: {
        "radius": 1500,
        "input": keyword,
        "type": "tourist_attraction",
      },
    );
    final places = (res.data?['data']['places'] as List);
    print(places);
    return places.map((e) => PlaceUserModel.fromMap(e)).toList();
  }
}
