import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_time_planner/components/avatar.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_detail_controller.dart';
import 'package:free_time_planner/routes/exports.dart';

class RecommendationDetailView extends StatelessWidget {
  const RecommendationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendationDetailController>(
      init: RecommendationDetailController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/sea.jpeg',
                        fit: BoxFit.cover,
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
                            children: const [
                              AppText(
                                'Senato hotel Milano',
                                fontWeight: FontWeight.w600,
                                size: 16,
                              ),
                              AppText(
                                'Via Senato, Milan, Metropolitan city of Milan, Italy',
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
                    child: sharingRow(),
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
                                'Charles Marcus',
                                fontWeight: FontWeight.w600,
                                size: 16,
                              ),
                              AppText(
                                '21 Feb. 2021',
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
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: AppText(
                        '''I was at first concerned by Bosco Verticale Restaurant‘s lack of real Internet presence, but don’t let their underwhelming Facebook page mislead you: locals love this place. 
            
The prices are great, especially for Milan. But more importantly, the food is surprisingly excellent, striking a welcome balance between hearty, creative, and well-executed. It’s also a great place for picky eaters as there are both exotic and more tame offerings for every course.  
            
FYI: This restaurant is named after the iconic Bosco Verticale tree skyscraper, which is nearby. It’s a notable landmark in Porto Nuevo. Be sure to check it out before or after your meal! '''),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: likeCommentShare(),
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

Widget sharingRow() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
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
      Container(
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
      Container(
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
    ],
  );
}

Widget likeCommentShare() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(CupertinoIcons.heart),
          SizedBox(
            width: 3.0,
          ),
          AppText(
            'Like',
          ),
        ],
      ),
      const SizedBox(
        width: 16.0,
      ),
      Row(
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
      const SizedBox(
        width: 16.0,
      ),
      Row(
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
    ],
  );
}
