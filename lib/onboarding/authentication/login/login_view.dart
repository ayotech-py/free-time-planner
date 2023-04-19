import 'package:flutter/cupertino.dart';
import 'package:free_time_planner/features/free_time_planner/bottom_nav_view.dart';
import 'package:free_time_planner/onboarding/authentication/login/login_viewmodel.dart';
import 'package:free_time_planner/onboarding/authentication/sign_up/sign_up_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            bottom: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                      child: SizedBox.fromSize(
                        //size: const Size.fromRadius(48), // Image radius
                        child: Image.asset(
                          AppAssets.intro1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: AppText(
                      'Login',
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: AppText(
                      'Welcome back and continue your journey',
                      alignment: TextAlign.center,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      //top: 16.0,
                      right: 16.0,
                    ),
                    //color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        textAndTextField(
                          controller: controller.emailController,
                          formName: 'Email Address',
                          hintText: 'wabais@example.com',
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        ///PassWord TextFields
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const AppText(
                              'Password',
                              size: 14,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            AppTextField(
                              obscureText: controller.show,
                              maxLines: 1,
                              suffixIcon: InkWell(
                                  onTap: controller.onObscure,
                                  child: Icon(
                                    controller.show == true
                                        ? CupertinoIcons.eye_fill
                                        : CupertinoIcons.eye_slash_fill,
                                    color: AppColors.textFieldBackgroundColor,
                                  )),
                              //obscureChar: 'g',
                              textInputAction: TextInputAction.done,
                              textEditingController: controller.passController,
                              hintText: '****************',
                              borderWidth: 2,
                            )
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppButton(
                              //color: AppColors.primaryColor,
                              onPressed: () {},
                              radius: 10,
                              disableElevation: 0.0,
                              hoverColor: Colors.transparent,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8.0, top: 16.0),
                                child: AppText(
                                  'Forget Password?',
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        AppButton(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.only(top: 24.0, bottom: 24.0),
                          color: AppColors.primaryColor,
                          onPressed: () {
                            controller.onLogin(context);
                          },
                          elevation: 0,
                          radius: 10,
                          child: Visibility(
                            visible: !controller.inProgress,
                            replacement: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            child: const AppText(
                              'Login',
                              color: Colors.white,
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),

                        ///Sign Up
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppText(
                              'Doesn\'t An Account?',
                              size: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const SignUpView());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: AppText(
                                  'Sign Up',
                                  size: 15,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget textAndTextField({
  required TextEditingController controller,
  required String formName,
  String? hintText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AppText(
        formName,
        size: 14,
      ),
      const SizedBox(
        height: 4,
      ),
      AppTextField(
        textEditingController: controller,
        hintText: formName,
        maxLines: 1,
        textInputType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        borderWidth: 2,
      )
    ],
  );
}
