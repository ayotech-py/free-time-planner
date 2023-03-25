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
                height: MediaQuery.of(context).size.height * 0.6,
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColors.primaryColor, // red as border color
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          controller.onPass();
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
