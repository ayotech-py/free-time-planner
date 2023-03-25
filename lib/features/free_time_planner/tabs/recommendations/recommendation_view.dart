import 'package:flutter/cupertino.dart';
import 'package:free_time_planner/components/recommendation_home_item.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/recommendations/recommendation_controller.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendationController>(
      init: RecommendationController(),
      autoRemove: false,
      builder: (controller) {
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await controller.fetchPlaces();
          },
          child: Scaffold(
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchAndtext(
                      controller: controller,
                    ),
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
                            child: AppText('No messages'),
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
                                      image: controller.resturants[index]
                                              .attractionImages!.isEmpty
                                          ? img[9]
                                          : controller.resturants[index]
                                              .attractionImages![0],
                                      isNetwork: controller.resturants[index]
                                          .attractionImages!.isEmpty,
                                      place: controller.resturants[index],
                                    ));
                              },
                              child: RecommendationHomeItem(
                                nearbyPlace: controller.resturants[index],
                              ));
                        },
                      );
                    }),

                    /*//RecommendationHomeItem(),
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                      image: img[index],
                                    ));
                              },
                              child: RecommendationHomeItem(
                                image: img[index],
                              ));
                        },
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SearchAndtext extends StatelessWidget {
  final RecommendationController controller;
  const SearchAndtext({super.key, required this.controller});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainA,
        children: [
          const AppText(
            'Recommendation For You',
            color: Colors.black,
            fontWeight: FontWeight.w600,
            size: 18,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                controller.selectedType,
                size: 20,
              ),
              AppButton(
                //width: double.infinity,
                padding: const EdgeInsets.only(
                    right: 8.0, top: 10.0, bottom: 10.0, left: 8.0),
                color: AppColors.primaryColor,
                onPressed: () {
                  controller.bottomBankSelection();
                },
                elevation: 0,
                radius: 10,
                child: const AppText(
                  'Select Category',
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          // Container(
          //   // height: 30,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       color: Colors.grey.shade200,
          //     ),
          //     child: const TextField(
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //         hintText: 'Search...',
          //         //contentPadding: EdgeInsets.all(10.0),
          //         prefixIcon: Icon(
          //           CupertinoIcons.search,
          //           color: Colors.black,
          //           //size: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
