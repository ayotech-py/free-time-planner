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
              child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.tour,
                height: MediaQuery.of(context).size.height * 1,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const AppText(
                'Free Time Planner',
                fontWeight: FontWeight.w600,
                size: 25,
              ),
              const SizedBox(
                height: 4.0,
              ),
              const AppText(
                'Welcome Back! Resume your journey from where you stop',
                alignment: TextAlign.center,
                size: 18,
              ),

              /*AnimatedBuilder(
                animation: controller.animation,
                builder: (BuildContext context, Widget? _) {
                  return AppText(
                    '''Free
     Time
         Planner''',
                    size: controller.animation.value,
                  );
                },
              ),*/
            ],
          )),
        );
      },
    );
  }
}
