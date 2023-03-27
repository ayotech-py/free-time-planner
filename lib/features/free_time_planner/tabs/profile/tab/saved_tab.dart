import 'package:free_time_planner/components/recommendation_home_item.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/profile/profile_controller.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class SavedTabView extends StatelessWidget {
  const SavedTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.isLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
          );
        }
        if (controller.resturants.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: AppText('No messages'),
            ),
          );
        }
        return GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: 20,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
                onTap: () {
                  Get.to(() => RecommendationDetailView(
                        isNetwork: controller
                            .resturants[index].attractionImages!.isEmpty,
                        place: controller.resturants[index],
                        image: controller
                                .resturants[index].attractionImages!.isEmpty
                            ? img[5]
                            : controller.resturants[index].attractionImages![0],
                      ));
                },
                child: RecommendationHomeItem(
                  nearbyPlace: controller.resturants[index],
                ));
          },
        );
      },
    );
  }
}
