import 'dart:async';

import 'package:dio/dio.dart';
import 'package:free_time_planner/constants/app_api_config.dart';
import 'package:free_time_planner/models/places/place_user_model.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:free_time_planner/routes/exports.dart';

typedef ResMap = Map<String, dynamic>;
typedef ResList = List<Map<String, dynamic>>;

class PlaceRepoImpl {
  bool isLoading = true;
  final _dio = Dio();

  Future<List<PlaceUserModel>> getNewPlaces({
    required double? lat,
    required double? long,
    required String type,
  }) async {
    print('place user 22222 print');
    final res = await _dio.postUri<ResMap>(
      //
      //'https://tourist-attraction-api.onrender.com/places/tourist_attraction',
      AppApiConfig.getbyType(),
      data: {
        "lng": long ?? -73.58781,
        "lat": lat ?? 45.50884,
        "type": type,
        'location': 'Europe',
      },
    );
    //final places = (res.data?['data']['names'] as List);
    final places = (res as List);
    return places.map((e) => PlaceUserModel.fromMap(e)).toList();
  }

  Future<List<PlaceUserModel>> getByKeyword({
    required double? lat,
    required double? long,
    required String type,
    required String keyword,
  }) async {
    print('place user print');
    final res = await https.post(
      Uri.parse(
          'https://touristattractionapi-production.up.railway.app/places/tourist_search/'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'keyword': keyword, "location": keyword, 'budget': 2000}),
    );
    try {
      final places = (json.decode(res.body)['data'] as List);
      return places.map((e) => PlaceUserModel.fromMap(e)).toList();
    } catch (error) {
      UserAuth userAuth = UserAuth();

      final userinfo = await userAuth.getUserData();
      //print(userinfo);

      final country = userinfo['country'] ?? '';
      final res = await https.post(
        Uri.parse(
            'https://touristattractionapi-production.up.railway.app/places/tourist_search/'),
        headers: {'Content-Type': 'application/json'},
        body: json
            .encode({'keyword': country, "location": country, 'budget': 2000}),
      );
      final places = (json.decode(res.body)['data'] as List);
      return places.map((e) => PlaceUserModel.fromMap(e)).toList();
    }
  }

  Future<List<PlaceUserModel>> getBySearch({
    required double? lat,
    required double? long,
    required String type,
    required String keyword,
  }) async {
    print('place user print');
    final res = await https.post(
      Uri.parse(
          'https://touristattractionapi-production.up.railway.app/places/tourist_search/'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'keyword': keyword, "location": keyword, 'budget': 2000}),
    );
    try {
      final places = (json.decode(res.body)['data'] as List);
      return places.map((e) => PlaceUserModel.fromMap(e)).toList();
    } catch (error) {
      return [];
    }
  }

  Future<List<PlaceUserModel>> getByProvince({
    //required String type,
    required String keyword,
  }) async {
    UserAuth userAuth = UserAuth();

    final userinfo = await userAuth.getUserData();
    //print(userinfo);

    final country = userinfo['country'] ?? '';
    final budget = userinfo['budget'] ?? '';

    keyword = keyword.substring(0, keyword.length - 8);

    final res = await https.post(
      Uri.parse(
          'https://touristattractionapi-production.up.railway.app/places/tourist_search/'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'keyword': keyword, "location": keyword, 'budget': budget}),
    );
    final places = (json.decode(res.body)['data'] as List);
    return places.map((e) => PlaceUserModel.fromMap(e)).toList();
  }
}
