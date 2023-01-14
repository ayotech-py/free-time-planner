import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_time_planner/routes/exports.dart';

class RecommendationHomeItem extends StatelessWidget {
  const RecommendationHomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/sea.jpeg',
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                AppText(
                  'La Mercerie',
                  size: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
