import 'package:free_time_planner/routes/exports.dart';

class ThirdIntro extends StatelessWidget {
  const ThirdIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          child: Image.asset(
            AppAssets.intro3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              'Saves',
              color: AppColors.primaryColor,
              size: 30,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: AppText(
                'Save and find friends recommendation and review of places visited',
                color: Colors.black,
                alignment: TextAlign.center,
                size: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
