import 'package:free_time_planner/routes/exports.dart';

class HomeController extends GetxController {
  int tabIndex = 0;
  void onTabChanged(int value) {
    tabIndex = value;
    update();
  }
}
