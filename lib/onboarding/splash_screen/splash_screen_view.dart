import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_time_planner/onboarding/splash_screen/splash_screen_controller.dart';
import 'package:free_time_planner/routes/exports.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
              child: AnimatedBuilder(
            animation: controller.animation,
            builder: (BuildContext context, Widget? _) {
              return AppText(
                '''Free
     Time
         Planner''',
                size: controller.animation.value,
              );
            },
          )),
        );
      },
    );
  }
}
