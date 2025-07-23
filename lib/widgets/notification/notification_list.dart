import 'package:flutter/material.dart';
import 'package:CaloriesBuddy/models/notifications.dart';
import 'package:CaloriesBuddy/widgets/notification/notification_tile.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationModel> notifications;
  final Function(String) onMarkAsRead;
  final Function(String) onDelete;

  const NotificationList({super.key, required this.notifications, required this.onMarkAsRead, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text('ไม่มีการแจ้งเตือน', style: TextTheme.of(context).titleLarge!.copyWith(color: Colors.grey[600])),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationTile(
          notification: notification,
          onTap: () => onMarkAsRead(notification.id),
          onDelete: () => onDelete(notification.id),
        );
      },
    );
  }
}