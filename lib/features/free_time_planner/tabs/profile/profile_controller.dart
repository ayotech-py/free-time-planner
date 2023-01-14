import 'package:free_time_planner/routes/exports.dart';

class ProfileController extends GetxController {
  String bio =
      'The prices are great, especially for Milan. But more importantly, the food is surprisingly excellent, striking a welcome balance between hearty, creative, and well-executed. It’s also a great place for picky eaters as there are both exotic and more tame offerings for every course.';

  int tabIndex = 0;
  void onTabChanged(int value) {
    tabIndex = value;
    update();
  }
}
