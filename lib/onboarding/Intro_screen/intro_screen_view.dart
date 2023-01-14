import 'package:free_time_planner/onboarding/Intro_screen/intro_controller.dart';
import 'package:free_time_planner/onboarding/Intro_screen/intros/first_intro.dart';
import 'package:free_time_planner/onboarding/Intro_screen/intros/forth_intro.dart';
import 'package:free_time_planner/onboarding/Intro_screen/intros/second_intro.dart';
import 'package:free_time_planner/onboarding/Intro_screen/intros/third_intro.dart';
import 'package:free_time_planner/onboarding/authentication/login/login_view.dart';
import 'package:free_time_planner/routes/exports.dart';

class IntroScreenView extends StatelessWidget {
  const IntroScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroScreenController>(
      init: IntroScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              //const Spacer(),
              Expanded(
                child: PageView(
                  //physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  children: const [
                    FirstIntro(),
                    SecondIntro(),
                    ThirdIntro(),
                    ForthIntro(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 36.0,
                ),
                child: Row(
                  children: [
                    Visibility(
                      visible: !(controller.index == 3),
                      replacement: AppText(
                        'Skip',
                        size: 20,
                        color: AppColors.textFieldBackgroundColor,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.off(() => const LoginView());
                        },
                        child: const AppText(
                          'Skip',
                          size: 20,
                        ),
                      ),
                    ),
                    const Spacer(),

                    ///Three dot indicator
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.index == 0
                                ? AppColors.primaryColor
                                : AppColors.textFieldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.index == 1
                                ? AppColors.primaryColor
                                : AppColors.textFieldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.index == 2
                                ? AppColors.primaryColor
                                : AppColors.textFieldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.index == 3
                                ? AppColors.primaryColor
                                : AppColors.textFieldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    !(controller.index == 3)
                        ? InkWell(
                            onTap: () {
                              controller.pageNavigator();
                            },
                            child: const AppText(
                              'Next',
                              size: 20,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Get.off(() => const LoginView());
                            },
                            child: const AppText(
                              'Start',
                              size: 20,
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
