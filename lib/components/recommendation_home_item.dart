import 'package:cached_network_image/cached_network_image.dart';
import 'package:free_time_planner/models/places/place_user_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/utils/utils.dart';

class RecommendationHomeItem extends StatelessWidget {
  final PlaceUserModel nearbyPlace;
  const RecommendationHomeItem({super.key, required this.nearbyPlace});

  @override
  Widget build(BuildContext context) {
    //double height = 150;
    return Container(
      color: Colors.white,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            //height: 150,
            child: nearbyPlace.attractionImages!.isEmpty
                ? Image.asset(
                    img[20],
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: nearbyPlace.attractionImages![0],
                    placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        img[20],
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
            child: AppText(
              nearbyPlace.attractionName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
