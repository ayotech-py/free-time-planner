import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/data/local/localstorage.dart';
import 'package:free_time_planner/models/places/nearby_places_model.dart';
import 'package:free_time_planner/models/places/place_user_model.dart';
import 'package:free_time_planner/models/places/position_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';
import 'package:geocoding/geocoding.dart';

class FoodAndDrinkPageController extends GetxController {
  int tabIndex = 0;
  bool isLoading = true;
  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();
  PlaceRepoImpl placeRepo = PlaceRepoImpl();
  String? currentAddress;
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();
  Position? currentPosition;

  List<PlaceUserModel> resturants = [];

  @override
  void onInit() async {
    //await getCurrentPosition();
    //print('long ${currentPosition!.longitude}, Latitude ${currentPosition!.latitude}');
    await fetchPlaces();
    update();
    analyticsService.logCurrentScreen(name: 'Resturant page');
    analyticsService.logUserId(id: FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
  }

  //This initializes and fetch the contacts from the api
  Future<void> fetchPlaces() async {
    isLoading = true;
    update();
    try {
      /// The future await will run the funcion one after the other even if an endpoint throw an error it will continue with others.
      await Future.wait([
        placeRepo
            .getNewPlaces(
                lat:
                    //'45.50884',
                    currentUserPosition.lat,
                long:
                    //'73.58781',
                    currentUserPosition.long,
                type: 'restaurant')
            .then((value) => resturants = value),
      ]);
    } on Exception catch (e) {
      //This will show whenever there's issue with any of the api
      Get.snackbar(
        "Error",
        'Something went wrong. Pull down to refresh',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
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

  UserPosition get currentUserPosition => LocalStorage().getUserPosition();
}
