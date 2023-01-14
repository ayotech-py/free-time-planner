import 'package:free_time_planner/routes/exports.dart';

class LoginController extends GetxController {
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

  Future<void> onLogin(BuildContext context) async {}
}
