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
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            top: true,
            child: Column(
              children: [
                const SearchAndtext(),
                //RecommendationHomeItem(),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchAndtext extends StatelessWidget {
  const SearchAndtext({super.key});

  @override
  Widget build(BuildContext context) {
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
          Container(
            // height: 30,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  //contentPadding: EdgeInsets.all(10.0),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                    //size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
