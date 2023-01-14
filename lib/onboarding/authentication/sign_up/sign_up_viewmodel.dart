import 'package:free_time_planner/routes/exports.dart';

class SignUpController extends GetxController {
  //Defining the textcontrollers
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  //TextEditingController userNameController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  /// Show pass controls the hiding and ahowing of password while showConfirmPass also do the same for confirm pass word field,
  /// Terms is for checkbox in the sign up form. InProgress will handle the circular progress in the signUp button
  bool showPass = true;
  bool showConfirmPass = true;
  bool inProgress = false;
  bool terms = false;

  ///This is to hide the password
  void onObscurePass() {
    if (showPass) {
      showPass = false;
    } else {
      showPass = true;
    }

    update();
  }

  //This obscure the confirmPassword
  void onObscureConfirmPass() {
    if (showConfirmPass) {
      showConfirmPass = false;
    } else {
      showConfirmPass = true;
    }

    update();
  }

  ///This handles the onclick of the terms
  void onTermAccept(bool newval) {
    terms = newval;
    update();
  }

  ///When user clicks the sign up
  /*Future<void> onSignup(BuildContext context) async {
    ///Checking if no fields are empty. Toast will be shown if it is empty
    if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Email cannot be emoty');
    } else if (fullNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Fullname field cannot be empty');
    } else if (userNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'UserName field cannot be empty');
    } else if (passController.text.isEmpty ||
        confirmPassController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Password field cannot be empty');
    } else if (userNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'UserName field cannot be empty');
    } else if (passController.text != confirmPassController.text) {
      Fluttertoast.showToast(msg: 'Password doesn\'t match');
    } else if (terms == false) {
      Fluttertoast.showToast(msg: 'Accept the terms and conditions');
    } else {
      
    }
  }*/
}
