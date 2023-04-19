import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:free_time_planner/models/comment_model/comment_model.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';
import 'package:jiffy/jiffy.dart';

class CommentController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  List<QueryDocumentSnapshot> comments = [];
  UserModel userData = UserModel();
  UserAuth userAuth = UserAuth();
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();
  List<CommentModel> commentsList = [];
  int limit = 20;
  int limitIncrement = 20;
  final ScrollController listScrollController = ScrollController();

  @override
  void onInit() async {
    listScrollController.addListener(scrollListener);
    await user();
    update();
    await analyticsService.logCurrentScreen(name: 'Comment page');
    super.onInit();
  }

  Future<void> user() async {
    final userinfo = await userAuth.getUserData();

    userData = UserModel(
      avatar: userinfo['avatar'],
      email: userinfo['email'],
      fullName: userinfo['fullName'],
      passWord: userinfo['passWord'],
      age: userinfo['age'],
      location: userinfo['location'],
      country: userinfo['country'],
    );
    update();
  }

  Stream<QuerySnapshot> getStreamFireStore(String placeId) {
    return FirebaseFirestore.instance
        .collection('comment')
        .doc(placeId)
        .collection('comments')
        .snapshots();
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      limit += limitIncrement;
      update();
    }
  }

  Future deleteComment(String commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('comment')
          .doc(commentId)
          .delete();
    } on Exception catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        'Unable to delete comment',
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<bool> postComment(
    String commentId,
  ) async {
    try {
      //await _getDate();
      DateTime dateNow = DateTime.now();
      final date = Jiffy(dateNow).format('dd-MM-yyyy');
      final time = Jiffy(dateNow).format(' h:mm:ss a');

      try {
        final docRef = FirebaseFirestore.instance
            .collection('comment')
            .doc(commentId)
            .collection('comments')
            .doc();
        await docRef.set({
          'userName': userData.fullName,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'comment': textEditingController.text,
          'commentId': docRef.id,
          'timeStamp': Timestamp.now(),
          'avatar': userData.avatar,
          'date': date,
          'time': time
        });
        await analyticsService.logEvent(eventName: 'comments', param: {
          'Sent Comment': textEditingController.text,
        });
        //commentInrement(articleId, type);
        return true;
      } catch (e) {
        debugPrint(e.toString());
        Get.snackbar(
          "Error",
          'Unable to post comment',
          dismissDirection: DismissDirection.horizontal,
          colorText: Colors.white,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      print(e);
      return false;
      // throw Exception('Failed to post comment');
    }
  }
}
