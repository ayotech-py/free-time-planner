import 'package:free_time_planner/models/user/user_model.dart';
import 'package:free_time_planner/onboarding/authentication/login/login_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/user_service/user_auth.dart';

class HomeController extends GetxController {
  int tabIndex = 0;
  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();

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
}
