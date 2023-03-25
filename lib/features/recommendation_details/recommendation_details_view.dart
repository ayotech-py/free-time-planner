import 'package:flutter/cupertino.dart';
import 'package:free_time_planner/components/avatar.dart';
import 'package:free_time_planner/features/comment_page/comment_view.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_detail_controller.dart';
import 'package:free_time_planner/models/places/nearby_places_model.dart';
import 'package:free_time_planner/models/places/place_user_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:share_plus/share_plus.dart';

class RecommendationDetailView extends StatelessWidget {
  final String image;
  final bool isNetwork;
  final PlaceUserModel place;
  const RecommendationDetailView(
      {super.key,
      required this.image,
      required this.isNetwork,
      required this.place});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendationDetailController>(
      init: RecommendationDetailController(),
      // initState: (state) async {
      //   await state.controller?.fetchPlaces('');
      // },
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              top: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      isNetwork
                          ? Image.asset(
                              image,
                              fit: BoxFit.cover,
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: PageView.builder(
                                itemCount: place.attractionImages!.length,
                                controller: controller.pageController,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    place.attractionImages![index],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                },
                              ),
                            ),
                      Positioned(
                        left: 10.0,
                        top: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                place.attractionName ?? 'Free time planner',
                                //'Senato hotel Milano',
                                fontWeight: FontWeight.w600,
                                size: 16,
                              ),
                              AppText(
                                place.attractionAddress.toString(),
                                // 'Via Senato, Milan, Metropolitan city of Milan, Italy',
                                size: 14,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Icon(Icons.bookmark_add_outlined)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: sharingRow(
                        onContactTap: () {
                          launchUrlStart(
                              url:
                                  'tel://${place.internationalPhoneNumber ?? ''}');
                          print(place.internationalPhoneNumber);
                        },
                        onMapTap: () {
                          MapsLauncher.launchQuery(place.attractionAddress!);
                          //launchUrlStart(url: controller.place.url ?? '');
                        },
                        onWebsiteTap: () {}),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Divider(),
                  //The person recommending
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Avatar.medium(
                          url:
                              'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              AppText(
                                'Free Time Planner',
                                fontWeight: FontWeight.w600,
                                size: 16,
                              ),
                              AppText(
                                '19 Jan. 2023',
                                size: 14,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.share)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Builder(
                    builder: (context) {
                      if (place.weekdayText!.weekdayText!.isNotEmpty) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const AppText(
                                'Acticities',
                                size: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              ...place.weekdayText!.weekdayText!
                                  .map((e) => AppText(e))
                                  .toList()
                            ],
                          ),
                        );
                      }
                      return Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: AppText(
                              '''I know you'll love ${place.attractionName} with their pleasing environment and their loving customer service. 

You can reach them on ${place.internationalPhoneNumber} or visit them at 
${place.attractionAddress}.''')

                          //  The prices are great, especially for Milan. But more importantly, the food is surprisingly excellent, striking a welcome balance between hearty, creative, and well-executed. It’s also a great place for picky eaters as there are both exotic and more tame offerings for every course.

                          //FYI: This restaurant is named after the iconic Bosco Verticale tree skyscraper, which is nearby. It’s a notable landmark in Porto Nuevo. Be sure to check it out before or after your meal! ),
                          );
                    },
                  ),

                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: likeCommentShare(
                      onCommenTap: () {
                        Get.to(
                          () => CommentPageView(
                              commentId: place.reference ?? 'no Id comments'),
                        );
                      },
                      onLikeTap: () {},
                      onShareTap: () async {
                        await Share.share(
                          'Look at ${place.attractionName} it is located at ${place.attractionAddress} and I know you\'ll love it. You can contact them at ${place.internationalPhoneNumber}. Recommendation by Free Time Planner!!!',
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 24.0,
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

Widget sharingRow({
  required Function() onContactTap,
  required Function() onWebsiteTap,
  required Function() onMapTap,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: onWebsiteTap,
        child: Container(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColors.textFieldBackgroundColor),
          ),
          child: Column(
            children: const [
              Icon(Icons.exit_to_app),
              AppText(
                'Website',
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: onContactTap,
        child: Container(
          //width: double.infinity,
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColors.textFieldBackgroundColor),
          ),
          child: Column(
            children: const [
              Icon(Icons.email),
              AppText(
                'Contact',
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: onMapTap,
        child: Container(
          //width: double.infinity,
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 30.0, right: 30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColors.textFieldBackgroundColor),
          ),
          child: Column(
            children: const [
              Icon(Icons.location_on),
              AppText(
                'Map',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget likeCommentShare({
  required Function() onLikeTap,
  required Function() onCommenTap,
  required Function() onShareTap,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onLikeTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.star_circle_fill,
              color: AppColors.starColor,
            ),
            const SizedBox(
              width: 3.0,
            ),
            const AppText(
              '5.0',
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 16.0,
      ),
      GestureDetector(
        onTap: onCommenTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(CupertinoIcons.chat_bubble),
            SizedBox(
              width: 3.0,
            ),
            AppText(
              'Comment',
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 16.0,
      ),
      GestureDetector(
        onTap: onShareTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(CupertinoIcons.share),
            SizedBox(
              width: 3.0,
            ),
            AppText(
              'Share',
            ),
          ],
        ),
      ),
    ],
  );
}
