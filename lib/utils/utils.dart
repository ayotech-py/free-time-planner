import 'package:flutter/material.dart';
import 'package:free_time_planner/models/places/province_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// Function That Converts Hex Code To Flutter Recognized Color
///
/// [params]
/// [hexCode]: The Hex Code To Be Converted
///
/// Example
///
/// fromHex('#5265ff')
Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

///This Validate if an email address is correct
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this);
  }
}

///Lunching URl
Future<void> launchUrlStart({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

List<ProvinceModel> provinces = [
  ProvinceModel(
      placeName: 'Saskatchewan Province, Canada',
      lat: 55.000000,
      long: -106.000000),
  ProvinceModel(
      placeName: 'Prince Edward Island, Canada',
      lat: 46.250000,
      long: -63.000000),
  ProvinceModel(placeName: 'Ontario, Canada', lat: 50.000000, long: -85.000000),
  ProvinceModel(
      placeName: 'Nova Scotia, Canada', lat: 45.000000, long: -63.000000),
  ProvinceModel(
      placeName: 'Alberta, Canada', lat: 55.000000, long: -115.000000),
  ProvinceModel(
      placeName: 'British Columbia, Canada', lat: 53.726669, long: -127.647621),
  ProvinceModel(
      placeName: 'Manitoba, Canada', lat: 56.415211, long: -98.739075),
  ProvinceModel(
      placeName: 'Newfoundland and Labrador, Canada',
      lat: 53.135509,
      long: -57.660435),
  ProvinceModel(
      placeName: 'New Brunswick, Canada', lat: 46.498390, long: -66.159668),
  ProvinceModel(
      placeName: 'Quebec Province, Canada', lat: 53.000000, long: -70.000000),
];

List<String> img = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
  'assets/images/5.jpg',
  'assets/images/6.jpg',
  'assets/images/7.jpg',
  'assets/images/8.jpg',
  'assets/images/9.jpg',
  'assets/images/10.png',
  'assets/images/11.jpg',
  'assets/images/12.jpg',
  'assets/images/13.jpg',
  'assets/images/14.jpg',
  'assets/images/15.jpg',
  'assets/images/16.jpg',
  'assets/images/17.jpg',
  'assets/images/18.jpg',
  'assets/images/19.jpg',
  'assets/images/20.jpg',
  'assets/images/21.jpg',
  'assets/images/22.jpg',
  'assets/images/23.jpg',
  'assets/images/24.jpg',
  'assets/images/25.jpg',
  'assets/images/26.jpg',
  'assets/images/27.jpg',
  'assets/images/28.jpg',
  'assets/images/29.jpg',
  'assets/images/30.jpg',
  'assets/images/31.jpg',
  'assets/images/32.jpg',
  'assets/images/33.jpg',
  'assets/images/34.jpg',
];
