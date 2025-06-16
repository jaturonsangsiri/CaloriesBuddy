import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/theme/theme_bloc.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/models/notifications.dart';
import 'package:my_cal_track/widgets/notification/notification_list.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';
import 'package:my_cal_track/widgets/utils/respone.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<NotificationModel> notifications = [];
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadMockNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadMockNotifications() {
    // ข้อมูลตัวอย่าง
    notifications = [
      NotificationModel(
        id: '1',
        title: 'เตือนบันทึกแคลอรี่',
        message: 'อย่าลืมบันทึกมื้อเย็นของวันนี้นะ!',
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
        type: NotificationType.reminder,
      ),
      NotificationModel(
        id: '2',
        title: 'ยินดีด้วย! 🎉',
        message: 'คุณบรรลุเป้าหมายแคลอรี่ของวันนี้แล้ว',
        timestamp: DateTime.now().subtract(Duration(hours: 3)),
        type: NotificationType.achievement,
        isRead: true,
      ),
      NotificationModel(
        id: '3',
        title: 'คำเตือน',
        message: 'แคลอรี่ที่ได้รับวันนี้เกินเป้าหมาย 200 แคลอรี่',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        type: NotificationType.warning,
      ),
      NotificationModel(
        id: '4',
        title: 'ข้อมูลใหม่',
        message: 'มีการอัพเดทฐานข้อมูลอาหารใหม่ 50 รายการ',
        timestamp: DateTime.now().subtract(Duration(days: 2)),
        type: NotificationType.info,
        isRead: true,
      ),
    ];
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        notifications[index].isRead = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      notifications.removeWhere((n) => n.id == notificationId);
    });
  }

  List<NotificationModel> get unreadNotifications =>
      notifications.where((n) => !n.isRead).toList();

  List<NotificationModel> get allNotifications => notifications;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: systemwidgetcustom.appBarCustom(context, 'แจ้งเตือน', [
            IconButton(
              icon: Icon(Icons.done_all, color: Colors.white, size: Responsive.isTablet ? 35 : 25),
              onPressed: unreadNotifications.isNotEmpty ? _markAllAsRead : null,
              tooltip: 'อ่านทั้งหมด',
            ),
          ],
          PreferredSize(
            preferredSize: const Size.fromHeight(40), 
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return Container(
                  height: 40,
                  decoration: BoxDecoration(color: themeState.themeApp? backgroundColorDarkTheme : backgroundColorDarkTheme, borderRadius: BorderRadius.circular(4), border: Border.all(color: greyOne, width: 1)),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(color: themeState.themeApp? Colors.black45 : Colors.blueGrey[700],  borderRadius: BorderRadius.circular(4), border: Border.all(color: greyOne, width: 1)),
                    labelColor: Colors.white70,
                    unselectedLabelColor: themeState.themeApp? Colors.white : Colors.white54,
                    labelStyle: TextStyle(fontSize: Responsive.isTablet ? 20 : 16),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('ยังไม่อ่าน'),
                            if (unreadNotifications.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                                child: Text('${unreadNotifications.length}', style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Tab(text: 'ทั้งหมด'),
                    ]
                  ),
                );
              },
            )
          )
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            NotificationList(
              notifications: unreadNotifications,
              onMarkAsRead: _markAsRead,
              onDelete: _deleteNotification,
            ),
            NotificationList(
              notifications: allNotifications,
              onMarkAsRead: _markAsRead,
              onDelete: _deleteNotification,
            ),
          ],
        ),
      ),
    );
  }
}