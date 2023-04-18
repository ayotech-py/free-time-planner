import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/data/local/localstorage.dart';
import 'package:free_time_planner/data/repository/repo_implementation/place_repo_impl.dart';
import 'package:free_time_planner/models/places/nearby_places_model.dart';
import 'package:free_time_planner/models/places/position_model.dart';
import 'package:free_time_planner/models/user/user_model.dart';
import 'package:free_time_planner/onboarding/authentication/login/login_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';
import 'package:free_time_planner/services/user_service/user_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  int tabIndex = 0;
  bool isLoading = true;
  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();
  PlaceRepoImpl placeRepo = PlaceRepoImpl();
  String? currentAddress;
  Position? currentPosition;
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();

  List<NearbyPlaces> resturants = [];
  List<NearbyPlaces> hotels = [];
  List<NearbyPlaces> cinemas = [];
  List<NearbyPlaces> tour = [];
  List<NearbyPlaces> mull = [];
  List<NearbyPlaces> all = [];
  List<NearbyPlaces> others = [];

  @override
  void onInit() async {
    //await Future.delayed(Duration(seconds: 2));
    await user();
    await getCurrentPosition();
    analyticsService.logCurrentScreen(name: 'Home page');
    analyticsService.logUserId(id: FirebaseAuth.instance.currentUser!.uid);
    LocalStorage().setUserState(UserPosition(
        long: currentPosition!.longitude, lat: currentPosition!.latitude));
    print(
        'long ${currentPosition!.longitude}, Latitude ${currentPosition!.latitude}');
    //await fetchPlaces();
    update();
    super.onInit();
  }

  // //This initializes and fetch the contacts from the api
  // Future<void> fetchPlaces() async {
  //   isLoading = true;
  //   update();
  //   try {
  //     /// The future await will run the funcion one after the other even if an endpoint throw an error it will continue with others.
  //     await Future.wait([
  //       placeRepo
  //           .getAllPlaces(
  //               lat: '${currentPosition!.latitude}',
  //               long: '${currentPosition!.longitude}',
  //               type: 'resturants')
  //           .then((value) => resturants = value),
  //       placeRepo
  //           .getAllPlaces(
  //               lat: '${currentPosition!.latitude}',
  //               long: '${currentPosition!.longitude}',
  //               type: 'hotels')
  //           .then((value) => hotels = value),
  //       placeRepo
  //           .getAllPlaces(
  //               lat: '${currentPosition!.latitude}',
  //               long: '${currentPosition!.longitude}',
  //               type: 'cinemas')
  //           .then((value) => cinemas = value),
  //       placeRepo
  //           .getAllPlaces(
  //               lat: '${currentPosition!.latitude}',
  //               long: '${currentPosition!.longitude}',
  //               type: 'museum')
  //           .then((value) => tour = value),
  //       placeRepo
  //           .getAllPlaces(
  //               lat: '${currentPosition!.latitude}',
  //               long: '${currentPosition!.longitude}',
  //               type: 'mull')
  //           .then((value) => mull = value),
  //       placeRepo
  //           .getAllPlaces(
  //               lat: '${currentPosition!.latitude}',
  //               long: '${currentPosition!.longitude}',
  //               type: 'all')
  //           .then((value) => all = value),
  //       placeRepo
  //           .getAllPlaces(
  //               lat: '${currentPosition!.latitude}',
  //               long: '${currentPosition!.longitude}',
  //               type: 'others')
  //           .then((value) => others = value)
  //     ]);
  //   } on Exception catch (e) {
  //     //This will show whenever there's issue with any of the api
  //     Get.snackbar(
  //       "Error",
  //       'Something went wrong. Pull down to refresh',
  //       dismissDirection: DismissDirection.horizontal,
  //       colorText: Colors.white,
  //       backgroundColor: AppColors.appRed,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     log(e.toString());
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }

  Future<void> user() async {
    final userinfo = await userAuth.getUserData();

    userData = UserModel(
      avatar: userinfo['avatar'],
      email: userinfo['email'],
      fullName: userinfo['fullName'],
      passWord: userinfo['passWord'],
      age: userinfo['age'],
      location: userinfo['location'],
    );
    update();
  }

  void onTabChanged(int value) {
    tabIndex = value;
    update();
  }

  Future<void> logOut() async {
    await userAuth.logOut();
    Get.offAll(() => const LoginView());
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Error",
        'Location services are disabled. Please enable the services',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Error",
          'Location permissions are denied',
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Error",
        'Location permissions are permanently denied, we cannot request permissions.',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );

      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      update();
      _getAddressFromLatLng(currentPosition!);
      //print(currentPosition);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
          '${place.street}, ${place.postalCode}, ${place.subAdministrativeArea}, ${place.country}';
      update();
      //print(currentAddress);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}
