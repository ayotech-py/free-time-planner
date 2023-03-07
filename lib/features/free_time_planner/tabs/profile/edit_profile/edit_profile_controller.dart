import 'dart:io';

import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/user_service/user_auth.dart';

import '../../../../../models/user/user_model.dart';

class EditProfileController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  TextEditingController availableFromcontroller = TextEditingController();
  TextEditingController availableTocontroller = TextEditingController();

  File? pickedImage;

  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();
  bool inProgress = false;

  @override
  void onInit() async {
    //await Future.delayed(Duration(seconds: 2));
    await user();
    update();
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
      availableFrom: userinfo['availableFrom'] ?? '',
      availableTo: userinfo['availableTo'] ?? '',
      location: userinfo['location'],
    );
    namecontroller.text = userData.fullName ?? "";
    biocontroller.text = userData.bio ?? "";
    budgetcontroller.text = userData.budget ?? "";
    availableFromcontroller.text = userData.availableFrom ?? "";
    availableTocontroller.text = userData.availableTo ?? "";
    update();
  }

  void onUpdate() async {
    if (biocontroller.text.isEmpty) {
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
          bio: biocontroller.text,
          fullName: namecontroller.text,
          availableFrom: availableFromcontroller.text,
          availableTo: availableTocontroller.text,
          budget: budgetcontroller.text,
        );
        Get.back();
        inProgress = false;
        update();
      } on Exception catch (e) {
        Get.snackbar(
          "Error",
          e.toString(),
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      }
      inProgress = false;
      update();
    }
  }
  //final _picker = ImagePicker();
  //final _fireStorage = FirebaseStorage.instance;

  /*Future<void> pickImage() async {
    XFile? image;
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
    }
    await uploadImage();
    await finalUserData();
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
  }*/
}
