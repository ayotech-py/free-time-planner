import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/features/free_time_planner/bottom_nav_view.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:free_time_planner/routes/exports.dart';

import 'package:geocoding/geocoding.dart';

class SignUpController extends GetxController {
  final UserAuth userAuth = UserAuth();
  int currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  //Defining the textcontrollers
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  String userAddress = '';
  String? currentAddress;
  Position? currentPosition;

  /// Show pass controls the hiding and ahowing of password while showConfirmPass also do the same for confirm pass word field,
  /// Terms is for checkbox in the sign up form. InProgress will handle the circular progress in the signUp button
  bool showPass = true;
  bool showConfirmPass = true;
  bool inProgress = false;
  bool terms = false;

  ///This is to hide the password
  void onObscurePass() {
    if (showPass) {
      showPass = false;
    } else {
      showPass = true;
    }

    update();
  }

  //This obscure the confirmPassword
  void onObscureConfirmPass() {
    if (showConfirmPass) {
      showConfirmPass = false;
    } else {
      showConfirmPass = true;
    }

    update();
  }

  ///This handles the onclick of the terms
  void onTermAccept(bool newval) {
    terms = newval;
    update();
  }

  ///When user clicks the sign up
  Future<void> onSignup() async {
    ///Checking if no fields are empty. Toast will be shown if it is empty
    if (emailController.text.isEmpty) {
      Get.snackbar(
        "Error",
        'Email cannot be emoty',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      //Fluttertoast.showToast(msg: 'Email cannot be emoty');
    } else if (passController.text.isEmpty ||
        confirmPassController.text.isEmpty) {
      Get.snackbar(
        "Error",
        'Password field cannot be empty',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      // Fluttertoast.showToast(msg: 'Password field cannot be empty');
    } else if (passController.text != confirmPassController.text) {
      Get.snackbar(
        "Error",
        'Password doesn\'t match',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      //Fluttertoast.showToast(msg: 'Password doesn\'t match');
    } else if (fullNameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        'Fullname field cannot be empty',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      //Fluttertoast.showToast(msg: 'Fullname field cannot be empty');
    } else if (ageController.text.isEmpty) {
      Get.snackbar(
        "Error",
        'Age field cannot be empty',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    } else if (int.parse(ageController.text) < 18) {
      Get.snackbar(
        "Error",
        'You must be above 18 years old',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    } else if (terms == false) {
      Get.snackbar(
        "Error",
        'Accept the terms and conditions',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      //Fluttertoast.showToast(msg: 'Accept the terms and conditions');
    } else {
      try {
        inProgress = true;
        update();

        print(userAddress);
        await userAuth.registerWithEmailandPass(
          email: emailController.text,
          password: passController.text,
          fullName: fullNameController.text,
          age: ageController.text,
          location: currentAddress ?? 'no address',
        );
        await getCurrentPosition();
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'location': currentAddress,
        });
        Get.to(() => const BottomNavigationView());
        //Get.offAndToNamed(RoutesClass.getCreatePinRoute());
        print('done');
        inProgress = false;
        update();
      } on FirebaseAuthException catch (e) {
        inProgress = false;
        update();
        Get.snackbar(
          "Error",
          e.message!,
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
        print('done');
      }
    }
  }

  //print('done');

  void switchStepsType() {
    stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical;

    update();
  }

  void tapped(int step) {
    currentStep = step;
    update();
  }

  void continued() {
    currentStep < 1 ? currentStep += 1 : null;
    if (currentStep == 1) {
      onSignup();
    }
    update();
  }

  void cancel() {
    currentStep > 0 ? currentStep -= 1 : null;
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
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'location': '${place.subAdministrativeArea}, ${place.country}',
      });
      userAddress = currentAddress!;
      update();
      //print(currentAddress);
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
