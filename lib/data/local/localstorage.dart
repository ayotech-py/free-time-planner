import 'dart:developer';

import 'package:free_time_planner/models/places/position_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  Box get appBox => Hive.box('freetime');

  static LocalStorage instance = LocalStorage();

  LocalStorage();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserPositionAdapter());
    await Hive.openBox('freetime');
    log('boxOpend');
  }

  void setUserState(UserPosition val) {
    appBox.put('userState', val);
  }

  void setUserData(UserPosition val) {
    appBox.put('userData', val);
  }

  UserPosition getUserPosition() {
    return appBox.get('userState',
        defaultValue: UserPosition(long: -73.58781, lat: 45.50884));
  }

  // User getUserProfile() {
  //   return appBox.get(
  //     'userData',
  //     //defaultValue: null,
  //   );
  // }

  // void setAccessToken(String val) {
  //   appBox.put('accessToken', val);
  // }

  // String getAccessToken() {
  //   return appBox.get('accessToken', defaultValue: '');
  // }

  // void clearUserInfo() {
  //   appBox.delete('userData');
  //   appBox.delete('userState');
  // }

  // void setBgMessageInit(bool val) {
  //   appBox.put('bgMessage', val);
  // }

  // bool getBgMessageInit() {
  //   return appBox.get('bgMessage', defaultValue: false);
  // }
}


//visenyatargaryen@mailinator.com*/