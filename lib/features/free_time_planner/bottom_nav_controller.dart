import 'package:free_time_planner/features/free_time_planner/tabs/add_recommendation/add_recommendation_view.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_view.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/notifications/notification_view.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/profile/profile_view.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/recommendations/recommendation_view.dart';
import 'package:free_time_planner/routes/exports.dart';

class BottomNavController extends GetxController {
  int selectedIndex = 0;
  final List children = [
    const HomeView(),
    //const AddRecommendationView(),
    const ProfileView(),
    //const NotificationView(),
    const RecommendationView(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
