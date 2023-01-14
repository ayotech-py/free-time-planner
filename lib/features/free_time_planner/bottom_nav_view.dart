import 'package:flutter/cupertino.dart';
import 'package:free_time_planner/features/free_time_planner/bottom_nav_controller.dart';
import 'package:free_time_planner/routes/exports.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          body: controller.children[controller.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 20.0,
            //selectedFontSize: 14.0,
            //unselectedFontSize: 14.0,
            enableFeedback: true,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: IconThemeData(
              color: AppColors.primaryColor,
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.plus_square,
                ),
                label: 'Add Recommendation',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person_add,
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bell),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Recommendation',
              ),
            ],
            currentIndex: controller.selectedIndex,
            selectedItemColor: AppColors.primaryColor,
            onTap: controller.onItemTapped,
          ),
        );
      },
    );
  }
}
