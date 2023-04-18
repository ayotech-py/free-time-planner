import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_time_planner/components/avatar.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/profile/edit_profile/edit_profile_controller.dart';
import 'package:free_time_planner/routes/exports.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const AppText('Edit Profile'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Center(
                    child: AppText(
                      'Add a profile photo, name,telephone, and bio to let people know who you are',
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Center(
                      child: Stack(
                        children: [
                          controller.pickedImage == null
                              ? Avatar.largest(
                                  url: controller.userData.avatar ?? '',
                                )
                              : CircleAvatar(
                                  radius: 75,
                                  backgroundImage: FileImage(
                                    controller.pickedImage!,
                                  ),
                                ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle),
                              padding: const EdgeInsets.all(13.0),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  textAndTextField(
                    controller: controller.namecontroller,
                    formName: 'Enter your name',
                    hintText: 'Arash',
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  textAndTextField(
                      controller: controller.budgetcontroller,
                      formName: 'Enter your budget (\$)',
                      hintText: '\$200'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  textAndTextField(
                      controller: controller.countrycontroller,
                      formName: 'Desired Location',
                      hintText: 'Canada'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  textAndTextField(
                      controller: controller.availableFromcontroller,
                      formName: 'Available from',
                      hintText: 'Enter time in 24hours e.g 12:00'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  textAndTextField(
                    controller: controller.availableTocontroller,
                    formName: 'Available To',
                    hintText: 'Enter time in 24hours e.g 22:00',
                  ),
                  // const SizedBox(
                  //   height: 16.0,
                  // ),
                  // // textAndTextField(
                  // //     controller: controller.biocontroller,
                  // //     formName: 'Purpose of visit',
                  // //     minline: 5,
                  // //     maxLine: 6,
                  // //     hintText: 'Short description...'),
                  // // const SizedBox(
                  // //   height: 24.0,
                  // // ),
                  // const AppText(
                  //   'Favourite Category',
                  //   fontWeight: FontWeight.bold,
                  //   size: 18,
                  // ),
                  // const SizedBox(
                  //   height: 4.0,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 16.0,
                  //     right: 16.0,
                  //   ),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       AppText(
                  //         controller.selectedType,
                  //         size: 20,
                  //       ),
                  //       AppButton(
                  //         //width: double.infinity,
                  //         padding: const EdgeInsets.only(
                  //             right: 8.0, top: 10.0, bottom: 10.0, left: 8.0),
                  //         color: AppColors.primaryColor,
                  //         onPressed: () {
                  //           controller.bottomBankSelection();
                  //         },
                  //         elevation: 0,
                  //         radius: 10,
                  //         child: const AppText(
                  //           'Select Category',
                  //           color: Colors.white,
                  //           size: 18,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  AppButton(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    color: AppColors.primaryColor,
                    onPressed: () {
                      controller.onUpdate();
                    },
                    elevation: 0,
                    radius: 10,
                    child: Visibility(
                      visible: !controller.inProgress,
                      replacement: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      child: const AppText(
                        'Update',
                        color: Colors.white,
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
  int? maxLine,
  int? minline,
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
        hintText: hintText,
        maxLines: maxLine,
        minLines: minline,
        textInputType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        borderWidth: 2,
      )
    ],
  );
}
