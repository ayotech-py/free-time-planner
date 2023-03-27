import 'package:flutter/cupertino.dart';
import 'package:free_time_planner/features/free_time_planner/bottom_nav_view.dart';
import 'package:free_time_planner/onboarding/authentication/login/login_view.dart';
import 'package:free_time_planner/onboarding/authentication/sign_up/sign_up_viewmodel.dart';
import 'package:free_time_planner/routes/exports.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              top: true,
              bottom: true,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          child: SizedBox.fromSize(
                            //size: const Size.fromRadius(48), // Image radius
                            child: Image.asset(
                              AppAssets.intro2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: AppText(
                            'Sign Up',
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Center(
                          child: AppText(
                            'Create a new account and coonect with thousands of users',
                            alignment: TextAlign.center,
                            size: 16,
                          ),
                        ),
                        /*const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: AppText(
                    'Sign Up',
                    size: 25,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Center(
                  child: AppText(
                    'Create a new account and coonect with thousands of users',
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
                      //fullName TextField
                      textAndTextField(
                        controller: controller.fullNameController,
                        formName: ' Full Name',
                        hintText: 'Jeo John',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //Email TextField
                      textAndTextField(
                        controller: controller.emailController,
                        formName: 'Email Address',
                        hintText: 'wabais@example.com',
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      ///PassWord TextFields
                      textAndPasswordTextField(
                        controller: controller.passController,
                        formName: 'Password',
                        show: controller.showPass,
                        onShow: () {
                          controller.onObscurePass();
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      ///ConfirmPassWord TextFields
                      textAndPasswordTextField(
                        controller: controller.confirmPassController,
                        formName: 'Confirm Password',
                        show: controller.showConfirmPass,
                        onShow: () {
                          controller.onObscureConfirmPass();
                        },
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      ///Ter
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Checkbox(
                              splashRadius: 10,
                              activeColor: AppColors.primaryColor,
                              value: controller.terms,
                              onChanged: (val) {
                                controller.onTermAccept(val!);
                              },
                            ),
                          ),
                          const AppText(
                            'I accept the',
                            size: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                //Get.toNamed(RoutesClass.getLoginRoute());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: AppText(
                                  ' Terms of Service and Privacy Policy',
                                  size: 14,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppButton(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                        color: AppColors.primaryColor,
                        onPressed: () {
                          Get.to(() => const BottomNavigationView());
                        },
                        elevation: 0,
                        radius: 10,
                        child: const AppText(
                          'Sign Up',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                            'Have An Account?',
                            size: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: AppText(
                                'Sign In',
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
                ),*/
                        Stepper(
                          type: StepperType.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          currentStep: controller.currentStep,
                          onStepTapped: (step) => controller.tapped(step),
                          onStepContinue: controller.continued,
                          onStepCancel: controller.cancel,
                          steps: <Step>[
                            Step(
                              title: const Text('Account'),
                              content: Column(
                                children: <Widget>[
                                  //Email TextField
                                  textAndTextField(
                                    controller: controller.emailController,
                                    formName: 'Email Address',
                                    hintText: 'wabais@example.com',
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  ///PassWord TextFields
                                  textAndPasswordTextField(
                                    controller: controller.passController,
                                    formName: 'Password',
                                    show: controller.showPass,
                                    onShow: () {
                                      controller.onObscurePass();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  ///ConfirmPassWord TextFields
                                  textAndPasswordTextField(
                                    controller:
                                        controller.confirmPassController,
                                    formName: 'Confirm Password',
                                    show: controller.showConfirmPass,
                                    onShow: () {
                                      controller.onObscureConfirmPass();
                                    },
                                  ),
                                ],
                              ),
                              isActive: controller.currentStep >= 0,
                              state: controller.currentStep >= 0
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            Step(
                              title: const Text('About'),
                              content: Column(
                                children: <Widget>[
                                  //fullName TextField
                                  textAndTextField(
                                    controller: controller.fullNameController,
                                    formName: ' Full Name',
                                    hintText: 'Jeo John',
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  //fullName TextField
                                  textAndTextField(
                                    controller: controller.ageController,
                                    formName: 'Age',
                                    hintText: '12',
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  ///Ter
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Checkbox(
                                          splashRadius: 10,
                                          activeColor: AppColors.primaryColor,
                                          value: controller.terms,
                                          onChanged: (val) {
                                            controller.onTermAccept(val!);
                                          },
                                        ),
                                      ),
                                      const AppText(
                                        'I accept the',
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            //Get.toNamed(RoutesClass.getLoginRoute());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: AppText(
                                              ' Terms of Service and Privacy Policy',
                                              size: 14,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              isActive: controller.currentStep >= 0,
                              state: controller.currentStep >= 1
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            /*Step(
                        title: new Text('Mobile Number'),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Mobile Number'),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 0,
                        state: controller.currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),*/
                          ],
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
                              'Have An Account?',
                              size: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const LoginView());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: AppText(
                                  'Sign In',
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
                  ),
                  Positioned(
                    bottom: 0.0,
                    top: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: Visibility(
                      visible: controller.inProgress,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
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

Widget textAndPasswordTextField({
  required TextEditingController controller,
  required String formName,
  String? hintText,
  required bool show,
  required Function() onShow,
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
        obscureText: show,
        maxLines: 1,
        suffixIcon: InkWell(
            onTap: onShow,
            child: Icon(
              show == true
                  ? CupertinoIcons.eye_fill
                  : CupertinoIcons.eye_slash_fill,
              color: AppColors.textFieldBackgroundColor,
            )),
        //obscureChar: 'g',
        textInputAction: TextInputAction.done,
        textEditingController: controller,
        hintText: '****************',
        borderWidth: 2,
      )
    ],
  );
}
