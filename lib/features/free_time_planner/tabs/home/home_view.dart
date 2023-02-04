import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_time_planner/components/avatar.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/home_controller.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/all_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/experience_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/food_and_drinks_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/hit_last_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/hotel_and_acc_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/products_tab.dart';
import 'package:free_time_planner/features/free_time_planner/tabs/home/tabs/services_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
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
                      children: const [
                        Avatar.large(
                            url:
                                'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: AppText(
                            'Charles',
                            size: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.settings)
                      ],
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
                                  text: 'Hodels',
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Tab(text: 'Resturants'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Cinemas',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Malls',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Museuns',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(text: 'Favorites'),
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
                            child: const HitLastTab())
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
