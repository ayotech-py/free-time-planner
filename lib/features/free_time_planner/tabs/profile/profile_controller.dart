import 'package:free_time_planner/models/user/user_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/user_service/user_auth.dart';

class ProfileController extends GetxController {
  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();
  String bio =
      'The prices are great, especially for Milan. But more importantly, the food is surprisingly excellent, striking a welcome balance between hearty, creative, and well-executed. It’s also a great place for picky eaters as there are both exotic and more tame offerings for every course.';

  int tabIndex = 0;
  void onTabChanged(int value) {
    tabIndex = value;
    update();
  }

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
    update();
  }
}
