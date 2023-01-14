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
                    'Add a profile photo, name,telephone, and bio to let people know who you are',
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    size: 14,
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
                                      'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg')
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
                      hintText: 'Kelvin Nate'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  textAndTextField(
                      controller: controller.addresscontroller,
                      formName: 'Enter your address',
                      hintText: 'Quebec, Canada'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  textAndTextField(
                      controller: controller.biocontroller,
                      formName: 'Enter your bio',
                      minline: 5,
                      maxLine: 6,
                      hintText: 'Describe yourself...'),
                  const SizedBox(
                    height: 24.0,
                  ),
                  AppButton(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    color: AppColors.primaryColor,
                    onPressed: () {
                      //controller.onSignup(context);
                    },
                    elevation: 0,
                    radius: 10,
                    child: const AppText(
                      'Update Profile',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
