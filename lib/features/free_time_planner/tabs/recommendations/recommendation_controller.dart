import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:free_time_planner/data/local/localstorage.dart';

import 'package:free_time_planner/models/places/place_user_model.dart';
import 'package:free_time_planner/models/places/position_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';
import 'package:free_time_planner/utils/utils.dart';

import 'package:geocoding/geocoding.dart';

class RecommendationController extends GetxController {
  int tabIndex = 0;
  bool isLoading = true;
  PlaceRepoImpl placeRepo = PlaceRepoImpl();
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();
  TextEditingController searchController = TextEditingController();
  String? currentAddress;
  Position? currentPosition;
  List<PlaceUserModel> resturants = [];
  String selectedType = 'casino';
  bool inProgress = false;

  @override
  void onInit() async {
    //await Future.delayed(Duration(seconds: 2));
    // await getCurrentPosition();
    // print(
    //     'long ${currentPosition!.longitude}, Latitude ${currentPosition!.latitude}');
    await fetchPlaces();
    update();
    analyticsService.logCurrentScreen(name: 'Search page');
    analyticsService.logUserId(id: FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
  }

  //This initializes and fetch the contacts from the api
  Future<void> fetchPlaces() async {
    isLoading = true;
    update();
    try {
      print(
          'long ${currentUserPosition.long}, Latitude ${currentUserPosition.lat}');

      /// The future await will run the funcion one after the other even if an endpoint throw an error it will continue with others.
      await Future.wait([
        placeRepo
            .getByKeyword(
              lat: 45.50884,
              //currentUserPosition.lat,
              long: -73.58781,
              //currentUserPosition.long,
              type: 'tourist_attraction',
              keyword: searchController.text.isEmpty
                  ? 'tour'
                  : searchController.text,
            )
            .then((value) => resturants = value)
        //chatRepo.getAllUnReadContacts(currentUser!.token).then((value) => allUnreadContactList = value),
        //chatRepo .getAllReadContacts(currentUser!.token).then((value) => allReadContactList = value)
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

  void bottomBankSelection() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 36.0,
          bottom: 16.0,
        ),
        //color: Colors.white,
        height: 500,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                selectedType = listoftypes[index];
                update();
                Get.back();
                await fetchPlaces();
              },
              child: AppText(
                listoftypes[index],
                size: 22,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16.0,
            );
          },
          itemCount: listoftypes.length,
        ),
      ),
      enableDrag: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
    );
  }

  UserPosition get currentUserPosition => LocalStorage().getUserPosition();
}
