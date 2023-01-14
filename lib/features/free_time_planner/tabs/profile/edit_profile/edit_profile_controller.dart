import 'dart:io';

import 'package:free_time_planner/routes/exports.dart';

class EditProfileController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  File? pickedImage;
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
