import 'package:free_time_planner/features/free_time_planner/tabs/notifications/notification_controller.dart';
import 'package:free_time_planner/routes/exports.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            title: AppText(
              'Notifications',
              size: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          body: Center(
            child: AppText('No Notification... Check Later'),
          ),
        );
      },
    );
  }
}
