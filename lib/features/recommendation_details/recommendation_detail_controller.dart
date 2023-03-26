import 'dart:developer';

import 'package:free_time_planner/data/repository/repo_implementation/chat_repo_impl.dart';
import 'package:free_time_planner/models/places/place_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:jiffy/jiffy.dart';
import 'package:share_plus/share_plus.dart';

class RecommendationDetailController extends GetxController {
  late PageController pageController;
  PlaceRepoImpl placeRepo = PlaceRepoImpl();
  // Place place = Place(
  //   formattedAddress: '',
  //   formattedPhoneNumber: '',
  // );

  final date = Jiffy(DateTime.now()).format('dd-MM-yyyy');
  bool isLoading = true;

  @override
  void onInit() async {
    //await Future.delayed(Duration(seconds: 2));
    //await fetchPlaces('');
    pageController = PageController();
    update();
    super.onInit();
  }

  //This initializes and fetch the contacts from the api
  Future<void> fetchPlaces(String placeId) async {
    isLoading = true;
    update();
    try {
      /// The future await will run the funcion one after the other even if an endpoint throw an error it will continue with others.
      // await Future.wait([
      //   placeRepo
      //       .getPlace('ChIJVdaWvBD5TxARyw2lb_TTnn8')
      //       .then((value) => place = value)
      //   //chatRepo.getAllUnReadContacts(currentUser!.token).then((value) => allUnreadContactList = value),
      //   //chatRepo .getAllReadContacts(currentUser!.token).then((value) => allReadContactList = value)
      // ]);
      //print(place.url);
    } on Exception catch (e) {
      //This will show whenever there's issue with any of the api
      Get.snackbar(
        "Error",
        'Something went wrong. Pull down to refresh',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
