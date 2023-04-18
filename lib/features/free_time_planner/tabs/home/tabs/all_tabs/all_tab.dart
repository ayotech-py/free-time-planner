import 'package:free_time_planner/components/recommendation_home_item.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/all_tabs/all_tab_controller.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class AllTabView extends StatelessWidget {
  const AllTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllPageController>(
      autoRemove: false,
      init: AllPageController(),
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
        if (controller.all.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: AppText('No Place Found please drag down to refresh'),
            ),
          );
        }
        return GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: controller.all.length,
          itemBuilder: (BuildContext ctx, index) {
            final place = controller.all[index];
            return GestureDetector(
                onTap: () {
                  Get.to(() => RecommendationDetailView(
                        place: place,
                        isNetwork: place.about!.isEmpty,
                        image: place.about!.isEmpty ? img[5] : place.about![0],
                      ));
                },
                child: RecommendationHomeItem(
                  nearbyPlace: place,
                ));
          },
        );
      },
    );
  }
}
