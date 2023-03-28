import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/components/recommendation_home_item.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/others_page/others_controller.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class OthersTab extends StatelessWidget {
  const OthersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OthersPageController>(
      autoRemove: false,
      init: OthersPageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Text('Others'),
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
                  if (controller.others.isEmpty) {
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
                    itemCount: controller.others.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => RecommendationDetailView(
                                  place: controller.others[index],
                                  image: controller.others[index]
                                          .attractionImages!.isEmpty
                                      ? img[5]
                                      : controller
                                          .others[index].attractionImages![0],
                                  isNetwork: controller
                                      .others[index].attractionImages!.isEmpty,
                                ));
                            controller.analyticsService.logCurrentScreen(
                                name: controller.others[index].attractionName!);
                            controller.analyticsService.logUserId(
                                id: FirebaseAuth.instance.currentUser!.uid);
                          },
                          child: RecommendationHomeItem(
                            nearbyPlace: controller.others[index],
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
