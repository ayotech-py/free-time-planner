import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/features/free_time_planner/bottom_nav_view.dart';
import 'package:free_time_planner/onboarding/authentication/login/login_view.dart';
import 'package:free_time_planner/routes/exports.dart';

class SplashScreenController extends GetxController
    with GetTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    final curve =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    animation = Tween<double>(begin: 14, end: 25).animate(curve);
    controller.repeat();

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (user != null) {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      print('Authenticated');
      Get.to(() => const BottomNavigationView());
    } else {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      Get.to(() => const LoginView());
      print('Not authenticated');
    }
  }
}
