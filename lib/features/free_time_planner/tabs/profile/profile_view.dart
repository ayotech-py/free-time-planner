import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/components/avatar.dart';
import 'package:free_time_planner/components/recommendation_home_item.dart';

import 'package:free_time_planner/features/free_time_planner/tabs/profile/edit_profile/edit_profile_view.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/profile/profile_controller.dart';

import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';
import 'package:share_plus/share_plus.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      autoRemove: false,
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () async {
              //await controller.fetchPlaces();
              await controller.onInit();
            },
            child: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: AppText(
                              'Free Time Planner',
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.bottomBankSelection();
                            },
                            child: const Icon(Icons.location_on),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(() => const EditProfileView());
                              },
                              child: const Icon(Icons.settings))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    StreamBuilder(
                      stream: controller.getUserDataStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        return Column(
                          children: [
                            Avatar.largest(
                              url: snapshot.data?['avatar'] ?? '',
                              //'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            AppText(
                              snapshot.data?['fullName'] ?? 'Free Time Planner',
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        AppText(
                          controller.userData.country ?? 'Montreal, Canada',
                          size: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Visibility(
                      visible: controller.userData.bio == null,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: AppText(
                          controller.userData.bio ?? "",
                          size: 14,
                          alignment: TextAlign.center,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: AppButton(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        color: Colors.black,
                        onPressed: () async {
                          await Share.share(
                            'Download the Free Time Planner app now and enjoy recommendation of places you can visit. I know you\'ll love it.',
                          );
                        },
                        elevation: 0,
                        radius: 10,
                        child: const AppText(
                          'Invite friends',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: AppButton(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        color: AppColors.appRed,
                        onPressed: () async {
                          //controller.onSignup(context);
                          await controller.logOut();
                        },
                        elevation: 0,
                        radius: 10,
                        child: const AppText(
                          'Log Out',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // IconButton(
                    //         onPressed: () async {

                    //         },
                    //         icon: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: const [
                    //             Icon(
                    //               Icons.exit_to_app,
                    //             ),
                    //             AppText(
                    //               'Log Out',
                    //               size: 14,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    SizedBox(
                      height: 12.0,
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
                                      image: controller.resturants[index].about
                                          .toString(),
                                      //coming
                                      isNetwork: controller
                                          .resturants[index].about!.isEmpty,
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
                    // DefaultTabController(
                    //   length: 7,
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
                    //                 text: 'Hotels & Accommodation',
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 120,
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(4.0),
                    //                 child: Tab(text: 'Food, wine & Nightlife'),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(
                    //                 text: 'Recommended Experience',
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(
                    //                 text: 'Other Services',
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(
                    //                 text: 'resturantss & sightseeing',
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsets.all(4.0),
                    //               child: Tab(text: 'Outdoor activities'),
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
                    //         child: const resturantsTab(),
                    //       ),
                    //       Visibility(
                    //         visible: controller.tabIndex == 5,
                    //         child: const OthersTab(),
                    //       ),
                    //       Visibility(
                    //           visible: controller.tabIndex == 6,
                    //           child: const OutdoorTab()),
                    //       // Visibility(
                    //       //     visible: controller.tabIndex == 7,
                    //       //     child: const SavedTabView())
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
}
