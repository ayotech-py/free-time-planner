import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/data/local/localstorage.dart';
import 'package:free_time_planner/data/repository/repo_implementation/chat_repo_impl.dart';
import 'package:free_time_planner/models/places/nearby_places_model.dart';
import 'package:free_time_planner/models/places/place_user_model.dart';
import 'package:free_time_planner/models/places/position_model.dart';
import 'package:free_time_planner/models/places/province_model.dart';
import 'package:free_time_planner/models/user/user_model.dart';
import 'package:free_time_planner/onboarding/authentication/login/login_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';
import 'package:free_time_planner/services/user_service/user_auth.dart';
import 'package:free_time_planner/utils/utils.dart';
import 'package:geocoding/geocoding.dart';

class ProfileController extends GetxController {
  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();
  String bio =
      'The prices are great, especially for Milan. But more importantly, the food is surprisingly excellent, striking a welcome balance between hearty, creative, and well-executed. It’s also a great place for picky eaters as there are both exotic and more tame offerings for every course.';
  bool isLoading = true;
  String? currentAddress;
  Position? currentPosition;
  ProvinceModel selectedProvince = provinces[9];

  PlaceRepoImpl placeRepo = PlaceRepoImpl();

  List<PlaceUserModel> resturants = [];
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();
  int tabIndex = 0;
  void onTabChanged(int value) {
    tabIndex = value;
    update();
  }

  @override
  Future<void> onInit() async {
    //await Future.delayed(Duration(seconds: 2));
    // await getCurrentPosition();
    // print(
    //     'long ${currentPosition!.longitude}, Latitude ${currentPosition!.latitude}');
    await user();
    await fetchPlaces();
    analyticsService.logCurrentScreen(name: 'Profile page');
    update();
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
                  selectedProvince.lat,
              long:
                  //'-73.58781',
                  selectedProvince.long,
              type: 'tourist_attraction',
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

  Future<void> user() async {
    final userinfo = await userAuth.getUserData();

    userData = UserModel(
      avatar: userinfo['avatar'],
      email: userinfo['email'],
      fullName: userinfo['fullName'],
      passWord: userinfo['passWord'],
      age: userinfo['age'],
      bio: userinfo['bio'] ?? '',
      budget: userinfo['budget'] ?? '',
      availableFrom: userinfo['availableFrom'] ?? '',
      availableTo: userinfo['availableTo'] ?? '',
      location: userinfo['location'],
    );
    update();
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

  Future<void> logOut() async {
    await userAuth.logOut();
    Get.offAll(() => const LoginView());
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
                selectedProvince = provinces[index];
                update();
                Get.back();
                await fetchPlaces();
              },
              child: AppText(
                provinces[index].placeName,
                size: 22,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16.0,
            );
          },
          itemCount: provinces.length,
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
