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
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  const AppText(
                    'Input your constraints to get an optimal recommendation',
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      //controller.pickImage();
                    },
                    child: Center(
                      child: Stack(
                        children: [
                          controller.pickedImage == null
                              ? const Avatar.largest(
                                  url:
                                      'data:image/jpeg;base64,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')
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
                              padding: const EdgeInsets.all(8.0),
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
                  const SizedBox(
                    height: 16.0,
                  ),
                  textAndTextField(
                      controller: controller.biocontroller,
                      formName: 'Max_Distance ',
                      minline: 5,
                      maxLine: 6,
                      hintText: 'Distance willing to travel in km'),
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
