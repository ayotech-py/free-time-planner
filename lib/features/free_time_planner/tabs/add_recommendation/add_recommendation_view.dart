import 'package:free_time_planner/features/free_time_planner/tabs/add_recommendation/add_recommendation_controller.dart';
import 'package:free_time_planner/routes/exports.dart';

class AddRecommendationView extends StatelessWidget {
  const AddRecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRecommendationController>(
      init: AddRecommendationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
            title: const AppText('Add Recommendation'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  width: double.infinity,
                  height: 200,
                  padding: EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(child: AppText('Select Image')),
                ),
                SizedBox(
                  height: 16.0,
                ),
                textAndTextField(
                  controller: controller.namecontroller,
                  formName: 'Enter name',
                  maxLine: 1,
                  minline: 1,
                  hintText: 'Katty Hotels and bar',
                ),
                SizedBox(
                  height: 16.0,
                ),
                textAndTextField(
                  controller: controller.locationcontroller,
                  formName: 'Enter Location',
                  maxLine: 1,
                  minline: 1,
                  hintText: 'Street, city, State, country',
                ),
                SizedBox(
                  height: 16.0,
                ),
                textAndTextField(
                  controller: controller.descriptionController,
                  formName: 'Enter Description',
                  maxLine: 7,
                  minline: 6,
                  hintText: 'How much did yo love the outing',
                ),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: AppButton(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    color: AppColors.primaryColor,
                    onPressed: () {
                      //controller.onSignup(context);
                    },
                    elevation: 0,
                    radius: 10,
                    child: const AppText(
                      'Add Recommendation',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
              ],
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
  required int maxLine,
  required int minline,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    child: Column(
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
          minLines: minline,
          textEditingController: controller,
          hintText: hintText,
          maxLines: maxLine,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          borderWidth: 2,
        )
      ],
    ),
  );
}
