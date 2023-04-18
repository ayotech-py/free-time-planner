import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/components/recommendation_home_item.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/recommendation/all_recommendation_controller.dart';

import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class RecommendationTab extends StatelessWidget {
  const RecommendationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllRecommendationPageController>(
      autoRemove: false,
      init: AllRecommendationPageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const AppText('Reccomendations'),
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
                  if (controller.all.isEmpty) {
                    print('No place found alaye');
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
                    itemCount: controller.all.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => RecommendationDetailView(
                                  place: controller.all[index],
                                  image: controller.all[index].about!.isEmpty
                                      ? img[3]
                                      : controller.all[index].about![0],
                                  isNetwork:
                                      controller.all[index].about!.isEmpty,
                                ));
                            controller.analyticsService.logCurrentScreen(
                                name: controller.all[index].attractionName!);
                            controller.analyticsService.logUserId(
                                id: FirebaseAuth.instance.currentUser!.uid);
                          },
                          child: RecommendationHomeItem(
                            nearbyPlace: controller.all[index],
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
