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
                        'https://images.search.yahoo.com/images/view;_ylt=AwrEr83AyglkS00kPryJzbkF;_ylu=c2VjA3NyBHNsawNpbWcEb2lkA2JmZDk3ZGZmOTY3ZjljOGI1N2FlNGNmOGQ0YTE4ZTJkBGdwb3MDMQRpdANiaW5n?back=https%3A%2F%2Fimages.search.yahoo.com%2Fsearch%2Fimages%3Fp%3Delon%2Bmusk%2Bimage%26ei%3DUTF-8%26type%3DE210US91166G0%26fr%3Dmcafee%26h%3D1800%26tt%3DHow%2BTesla%2BCEO%2BElon%2BMusk%2Bmakes%2Band%2Bspends%2Bhis%2B%252423%2Bbillion%2Bfortune%2B...%26w%3D2400%26imgurl%3Dhttps%253A%252F%252Fstatic1.businessinsider.com%252Fimage%252F59f8dc483e9d25db458b5dfc-2400%252Fgettyimages-645671866.jpg%26rurl%3Dhttps%253A%252F%252Fwww.businessinsider.com%252Ftesla-elon-musk-net-worth-2017-10%26turl%3Dhttps%253A%252F%252Ftse1.mm.bing.net%252Fth%253Fid%253DOIP.k5mBS4TCgV1jk-4IvWjySAHaFj%2526pid%253DApi%2526rs%253D1%2526c%253D1%2526qlt%253D95%2526w%253D145%2526h%253D109%26tw%3D145.9%26th%3D109.2%26sigr%3D7I3BWnNRTdS9%26sigi%3D8Cr9bmdBrXfJ%26sigt%3DeTYAudEHrABl%26sigit%3DFtoYvKHCmwKB%26tab%3Dorganic%26ri%3D1&w=2187&h=1446&imgurl=d.newsweek.com%2Fen%2Ffull%2F2202919%2Felon-musk.jpg&rurl=https%3A%2F%2Fwww.newsweek.com%2Felon-musks-cruel-mockery-disabled-worker-exposes-ugly-truth-about-america-opinion-1786373&size=666.7KB&p=elon+musk+image&oid=bfd97dff967f9c8b57ae4cf8d4a18e2d&fr2=&fr=mcafee&tt=Elon+Musk%26%2339%3Bs+Cruel+Mockery+of+a+Disabled+Worker+Exposes+an+Ugly+Truth+...&b=0&ni=90&no=1&ts=&tab=organic&sigr=_oxtSUep_xVP&sigb=EjVT.tv5cO96&sigi=Dkhj5WoHj0mK&sigt=7ahjT5XqW.Dp&.crumb=jWk9hmAH5ep&fr=mcafee&type=E210US91166G0',
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
                    children: [
                      Icon(Icons.location_on),
                      AppText(
                        controller.userData.location ?? 'Montreal, Canada',
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
                                  text: 'Hotels & Accommodation',
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Tab(text: 'Food, wine & Nightlife'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Recommended Experience',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'Other Services',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(
                                  text: 'tours & sightseeing',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Tab(text: 'Outdoor activities'),
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
