import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_time_planner/components/avatar.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/all_tabs/all_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/recommendation/recommendation_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/resturant_page/food_and_drinks_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/outdoor_page/outdoor_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/hotels_page/hotel_and_acc_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/others_page/others_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tour_page/tour_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      autoRemove: false,
      init: HomeController(),
      builder: (controller) {
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            //await controller.fetchPlaces();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), //New
                            blurRadius: 15,
                            blurStyle: BlurStyle.normal,
                            spreadRadius: 5,
                            // offset: Offset(0, 0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 16.0,
                        //right: 16.0,
                        bottom: 8.0,
                      ),
                      child: Row(
                        children: [
                          StreamBuilder(
                            stream: controller.getUserDataStream(),
                            builder: (BuildContext context,
                                AsyncSnapshot<
                                        DocumentSnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              return Row(
                                children: [
                                  Avatar.medium(
                                    url: snapshot.data?['avatar'] ?? '',
                                    //'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  AppText(
                                    snapshot.data?['fullName'] ??
                                        'Free Time Planner',
                                    size: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                ],
                              );
                            },
                          ),
                          // IconButton(
                          //   onPressed: () async {
                          //     await controller.logOut();
                          //   },
                          //   icon: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: const [
                          //       Icon(
                          //         Icons.exit_to_app,
                          //       ),
                          //       AppText(
                          //         'Log Out',
                          //         size: 14,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: AppText(
                          'Explore Every bit of our recommendations of places you\'d love to visit ',
                          size: 20,
                          alignment: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        //maxCrossAxisExtent: 300,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: [
                          InkWell(
                            onTap: () async {
                              Get.to(() => const HotelAndAccommodationTab());
                            },
                            child: gridItem('Lodging', img[13]),
                          ),
                          InkWell(
                            onTap: () async {
                              Get.to(() => const OutdoorTab());
                            },
                            child: gridItem('Outdoor Activities', img[3]),
                          ),
                          InkWell(
                            onTap: () async {
                              Get.to(() => const FoodAndDrinks());
                            },
                            child: gridItem('Foods & Resturants', img[8]),
                          ),
                          InkWell(
                            onTap: () async {
                              Get.to(() => const TourTab());
                            },
                            child: gridItem('Tour and Sightseeing', img[2]),
                          ),
                          InkWell(
                            onTap: () async {
                              Get.to(() => const RecommendationTab());
                            },
                            child: gridItem('Recommendations', img[21]),
                          ),
                          InkWell(
                            onTap: () async {
                              Get.to(() => const OthersTab());
                            },
                            child: gridItem('Others', img[29]),
                          )
                        ],
                      ),
                    ),
                    // DefaultTabController(
                    //   length: 6,
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.only(left: 16),
                    //         color: Colors.white,
                    //         child: TabBar(
                    //           onTap: (value) => controller.onTabChanged(value),
                    //           indicatorColor: Colors.black,
                    //           isScrollable: true,
                    //           labelColor: Colors.black,
                    //           unselectedLabelColor: Colors.grey,
                    //           /*labelStyle: GoogleFonts.roboto(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500,
                    //           ),*/
                    //           padding: EdgeInsets.zero,
                    //           /*unselectedLabelStyle: GoogleFonts.(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500,
                    //           ),*/
                    //           tabs: const [
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(
                    //                 text: 'All',
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(
                    //                 text: 'Hotels and Accomodation',
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 120,
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(4.0),
                    //                 child: Tab(text: 'Food,wine and nightlife'),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(
                    //                 text: 'Recommended Experience',
                    //               ),
                    //             ),
                    //             // Padding(
                    //             //   padding: EdgeInsets.all(4.0),
                    //             //   child: Tab(
                    //             //     text: 'Outdoor Activities',
                    //             //   ),
                    //             // ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(
                    //                 text: 'Tours and sightseeing',
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(text: 'Other activities'),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Visibility(
                    //           visible: controller.tabIndex == 0,
                    //           child: const AllTabView()),
                    //       Visibility(
                    //           visible: controller.tabIndex == 1,
                    //           child: const HotelAndAccommodationTab()),
                    //       Visibility(
                    //           visible: controller.tabIndex == 2,
                    //           child: const FoodAndDrinks()),
                    //       Visibility(
                    //           visible: controller.tabIndex == 3,
                    //           child: const RecommendationTab()),
                    //       Visibility(
                    //         visible: controller.tabIndex == 4,
                    //         child: const TourTab(),
                    //       ),
                    //       Visibility(
                    //         visible: controller.tabIndex == 5,
                    //         child: const OthersTab(),
                    //       ),
                    //       // Visibility(
                    //       //     visible: controller.tabIndex == 6,
                    //       //     child: const HitLastTab())
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget gridItem(
    String name,
    String image,
  ) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
          opacity: 0.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), //New
            blurRadius: 15,
            blurStyle: BlurStyle.normal,
            spreadRadius: 5,
            // offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Center(
        child: AppText(
          name,
          alignment: TextAlign.center,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}
