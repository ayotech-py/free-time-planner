import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/components/recommendation_home_item.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/resturant_page/food_and_drink_controller.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class FoodAndDrinks extends StatelessWidget {
  const FoodAndDrinks({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodAndDrinkPageController>(
      autoRemove: false,
      init: FoodAndDrinkPageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const AppText('Foods and Drinks'),
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
                  if (controller.resturants.isEmpty) {
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
                    itemCount: controller.resturants.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => RecommendationDetailView(
                                  place: controller.resturants[index],
                                  image: controller.resturants[index]
                                          .attractionImages!.isEmpty
                                      ? img[5]
                                      : controller.resturants[index]
                                          .attractionImages![0],
                                  isNetwork: controller.resturants[index]
                                      .attractionImages!.isEmpty,
                                ));
                            controller.analyticsService.logCurrentScreen(
                                name: controller
                                    .resturants[index].attractionName!);
                            controller.analyticsService.logUserId(
                                id: FirebaseAuth.instance.currentUser!.uid);
                          },
                          child: RecommendationHomeItem(
                            nearbyPlace: controller.resturants[index],
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
