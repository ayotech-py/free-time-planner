import 'package:free_time_planner/components/recommendation_home_item.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tour_page/tour_controller.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class TourTab extends StatelessWidget {
  const TourTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TourPageController>(
      autoRemove: false,
      init: TourPageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const AppText('Tour and Sight-seeing'),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Builder(builder: (context) {
                  if (controller.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                    );
                  }
                  if (controller.tour.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: AppText(
                            'No Place Found please drag down to refresh'),
                      ),
                    );
                  }
                  return GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: controller.tour.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => RecommendationDetailView(
                                  place: controller.tour[index],
                                  image: controller
                                          .tour[index].attractionImages!.isEmpty
                                      ? img[5]
                                      : controller
                                          .tour[index].attractionImages![0],
                                  isNetwork: controller
                                      .tour[index].attractionImages!.isEmpty,
                                ));
                          },
                          child: RecommendationHomeItem(
                            nearbyPlace: controller.tour[index],
                          ));
                    },
                  );
                })
              ],
            ),
          )),
        );
      },
    );
  }
}
