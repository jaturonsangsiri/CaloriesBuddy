import 'package:flutter/material.dart';
import 'package:CaloriesBuddy/models/notifications.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationTile({super.key, required this.notification, required this.onTap, required this.onDelete});

  IconData _getIconByType(NotificationType type) {
    switch (type) {
      case NotificationType.reminder:
        return Icons.alarm;
      case NotificationType.achievement:
        return Icons.emoji_events;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.info:
        return Icons.info;
    }
  }

  Color _getColorByType(NotificationType type) {
    switch (type) {
      case NotificationType.reminder:
        return Colors.blue;
      case NotificationType.achievement:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.grey;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} นาทีที่แล้ว';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ชั่วโมงที่แล้ว';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} วันที่แล้ว';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => onDelete(),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.grey[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: notification.isRead ? Colors.grey[200]! : Colors.blue[200]!, width: notification.isRead ? 1 : 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: _getColorByType(notification.type).withValues(alpha: 0.1),
            child: Icon(_getIconByType(notification.type), color: _getColorByType(notification.type)),
          ),
          title: Row(
            children: [
              Expanded(child: Text(notification.title, style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold))),
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(notification.message, style: TextTheme.of(context).titleSmall!.copyWith(color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text(_formatTimestamp(notification.timestamp), style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.grey[600])),
            ],
          ),
          onTap: notification.isRead ? null : onTap,
          trailing: notification.isRead ? null : IconButton(icon: Icon(Icons.mark_email_read, color: Colors.grey[400]), onPressed: onTap, tooltip: 'ทำเครื่องหมายว่าอ่านแล้ว'),
        ),
      ),
    );
  }
}