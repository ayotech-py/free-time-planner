import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:free_time_planner/data/repository/repo_implementation/place_repo_impl.dart';
import 'package:free_time_planner/models/places/place_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';
import 'package:jiffy/jiffy.dart';
import 'package:share_plus/share_plus.dart';

class RecommendationDetailController extends GetxController {
  late PageController pageController;
  PlaceRepoImpl placeRepo = PlaceRepoImpl();
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();
  // Place place = Place(
  //   formattedAddress: '',
  //   formattedPhoneNumber: '',
  // );
  double defualtrating = 4.0;

  final date = Jiffy(DateTime.now()).format('dd-MM-yyyy');
  bool isLoading = true;

  @override
  void onInit() async {
    //await Future.delayed(Duration(seconds: 2));
    //await fetchPlaces('');
    pageController = PageController();
    update();
    analyticsService.logCurrentScreen(name: 'Details page');

    analyticsService.logUserId(id: FirebaseAuth.instance.currentUser!.uid);

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

  Future<void> sendRating({
    required String placeId,
    required String rating,
  }) async {
    final ref = FirebaseFirestore.instance
        .collection('ratings')
        .doc(placeId)
        .collection('ratings')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    ///the variable 'Snap' is getting the data using the .get()
    DocumentSnapshot snap = await ref.get();

    ///I'm checking if the user exist or not. if it exist we'll update the user then if it doesn't we'll create a new doc.
    if (snap.exists) {
      await ref.update({'rating': rating});
    } else {
      await ref.set({'rating': rating});
    }
  }

  void ratingDialog(String placeId) {
    Get.defaultDialog(
      title: 'Rate your experince',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBar.builder(
            initialRating: defualtrating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) async {
              print(rating);
              defualtrating = rating;
              update();
              Get.back();
              await sendRating(placeId: placeId, rating: rating.toString());
            },
          ),
        ],
      ),
    );
  }
}
