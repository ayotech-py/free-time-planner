import 'package:free_time_planner/components/avatar.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/all_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/experience_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/food_and_drinks_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/hit_last_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/hotel_and_acc_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/products_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/services_view.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/profile/edit_profile/edit_profile_view.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/profile/profile_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/profile/tab/saved_tab.dart';
import 'package:free_time_planner/routes/exports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
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
                              Get.to(() => const EditProfileView());
                            },
                            child: const Icon(Icons.settings))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Avatar.largest(
                    url:
                        'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  AppText(
                    controller.userData.fullName ?? 'Free Time Planner',
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on),
                      AppText(
                        'Toronto, Canada',
                        size: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Visibility(
                    visible: controller.bio.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: AppText(
                        controller.bio,
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
                      onPressed: () {
                        //controller.onSignup(context);
                      },
                      elevation: 0,
                      radius: 10,
                      child: const AppText(
                        'Follow and invite friends',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DefaultTabController(
                    length: 7,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          color: Colors.white,
                          child: TabBar(
                            onTap: (value) => controller.onTabChanged(value),
                            indicatorColor: Colors.black,
                            isScrollable: true,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            /*labelStyle: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),*/
                            padding: EdgeInsets.zero,
                            /*unselectedLabelStyle: GoogleFonts.(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),*/
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'All',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Hodels & Accommodation',
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Tab(text: 'Food & Drinks'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Experience',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Service',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Product',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(text: 'Hit List'),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: controller.tabIndex == 0,
                            child: const AllTabView()),
                        Visibility(
                            visible: controller.tabIndex == 1,
                            child: const HotelAndAccommodationTab()),
                        Visibility(
                            visible: controller.tabIndex == 2,
                            child: const FoodAndDrinks()),
                        Visibility(
                            visible: controller.tabIndex == 3,
                            child: const ExperienceTab()),
                        Visibility(
                          visible: controller.tabIndex == 4,
                          child: const ServicesTab(),
                        ),
                        Visibility(
                          visible: controller.tabIndex == 5,
                          child: const ProductTab(),
                        ),
                        Visibility(
                            visible: controller.tabIndex == 6,
                            child: const HitLastTab()),
                        Visibility(
                            visible: controller.tabIndex == 7,
                            child: const SavedTabView())
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
