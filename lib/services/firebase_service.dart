import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAnalyticsService {
  final _firebaseAnalytics = FirebaseAnalytics.instance;

  Future<void> logEvent(
      {required String eventName, Map<String, dynamic>? param}) async {
    await _firebaseAnalytics.logEvent(
      name: eventName,
      parameters: param,
    );
  }

  Future<void> logSelectedContent(
      {required String contentType, required String itemId}) async {
    await _firebaseAnalytics.logSelectContent(
      contentType: "image",
      itemId: itemId,
    );
  }

  Future<void> logDefaultEventParameters(Map<String, Object> value) async {
    await _firebaseAnalytics.setDefaultEventParameters(value);
  }

  Future<void> logUserProperty({required String name, String? value}) async {
    await _firebaseAnalytics.setUserProperty(name: name, value: value);
  }

  Future<void> logCurrentScreen({required String name}) async {
    await _firebaseAnalytics.setCurrentScreen(screenName: name);
  }

  Future<void> logUserId({required String id}) async {
    await _firebaseAnalytics.setUserId(id: id);
  }

  Future<void> logSearch({required String query}) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('resent search')
        .doc();
    await ref.set({'search text': query});
  }
}
