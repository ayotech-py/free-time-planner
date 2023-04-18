import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/features/free_time_planner/bottom_nav_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/user_service/user_auth.dart';

class LoginController extends GetxController {
  final UserAuth userAuth = UserAuth();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool show = true;
  bool inProgress = false;
  bool terms = false;

  ///This is to hide the password
  void onObscure() {
    if (show) {
      show = false;
    } else {
      show = true;
    }

    update();
  }

  Future<void> onLogin(BuildContext context) async {
    try {
      if (emailController.text.isEmpty) {
        Get.snackbar(
          "Error",
          'Email Cannot be empty',
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
      } else if (passController.text.isEmpty) {
        Get.snackbar(
          "Error",
          'Password Cannot be empty',
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        inProgress = true;
        update();
        await userAuth.loginWithEmailAndPass(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
        Get.to(() => const BottomNavigationView());
        inProgress = false;
        update();
      }
    } on FirebaseAuthException catch (e) {
      inProgress = false;
      update();
      Get.snackbar(
        "Error",
        e.message!,
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
