import 'package:free_time_planner/routes/exports.dart';
import 'package:free_time_planner/services/firebase_service.dart';

class AddRecommendationController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FirebaseAnalyticsService analyticsService = FirebaseAnalyticsService();
}
