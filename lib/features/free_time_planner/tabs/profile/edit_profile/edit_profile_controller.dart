import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';
import 'package:free_time_planner/services/user_service/user_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../models/user/user_model.dart';

class EditProfileController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  TextEditingController availableFromcontroller = TextEditingController();
  TextEditingController availableTocontroller = TextEditingController();
  final _picker = ImagePicker();
  final _fireStorage = FirebaseStorage.instance;
  File? pickedImage;
  String selectedType = 'resturant';
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();

  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();
  bool inProgress = false;
  List<String> listoftypes = [
    "amusement_park",
    "museum",
    "park",
    'museum',
    "tourist_attraction",
  ];

  @override
  void onInit() async {
    //await Future.delayed(Duration(seconds: 2));
    await user();
    update();
    analyticsService.logCurrentScreen(name: 'Edit Profile page');
    analyticsService.logUserId(id: FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
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
      country: userinfo['country'] ?? '',
      availableFrom: userinfo['availableFrom'] ?? '',
      availableTo: userinfo['availableTo'] ?? '',
      location: userinfo['location'],
    );
    namecontroller.text = userData.fullName ?? "";
    selectedType = userData.bio ?? "resturant";
    budgetcontroller.text = userData.budget ?? "";
    countrycontroller.text = userData.country ?? "";
    availableFromcontroller.text = userData.availableFrom ?? "";
    availableTocontroller.text = userData.availableTo ?? "";
    update();
  }

  void onUpdate() async {
    if (selectedType.isEmpty) {
      Get.snackbar(
        "Error",
        'Bio cannot be empty',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      try {
        inProgress = true;
        update();
        await userAuth.updateProfile(
          bio: selectedType,
          fullName: namecontroller.text,
          availableFrom: availableFromcontroller.text,
          availableTo: availableTocontroller.text,
          budget: budgetcontroller.text,
          country: countrycontroller.text,
        );
        Get.back();
        inProgress = false;
        update();
        Get.snackbar(
          "Success",
          'Profile Updated',
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          snackPosition: SnackPosition.TOP,
        );
      } on Exception catch (e) {
        Get.snackbar(
          "Error",
          e.toString(),
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        inProgress = false;
        update();
      }
    }
  }

  Future<void> pickImage() async {
    XFile? image;
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
    }
    await uploadImage();
    //await finalUserData();
    update();
  }

  ///Upload the image picked to firebase storage and assign uploadUrl to the uploaded picture(we are getting a string which is in form of link)
  Future<void> uploadImage() async {
    if (pickedImage != null) {
      final ref = _fireStorage
          .ref('userProfileImage')
          .child(FirebaseAuth.instance.currentUser!.uid);
      String? uploadUrl;
      try {
        await ref.putFile(pickedImage!);
        uploadUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'avatar': uploadUrl,
        });
        Get.snackbar(
          "Sucsess",
          'Image Uploaded Successfully',
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor,
          snackPosition: SnackPosition.TOP,
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          'Unable to Image',
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
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
              onTap: () {
                selectedType = listoftypes[index];
                update();
                Get.back();
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
}
