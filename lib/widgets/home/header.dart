import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/theme/theme_bloc.dart';
import 'package:my_cal_track/bloc/user/user_bloc.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/pages/notification_page.dart';
import 'package:my_cal_track/pages/profile_page.dart';
import 'package:my_cal_track/widgets/icons_style.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';
import 'package:my_cal_track/widgets/utils/respone.dart';

// แสดงหัวข้อชื่อผู้ใช้ รูปโปรไฟล์ และเมนูแจ้งเตือนและตั้งค่า
class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  CustomPopupMenuItem? _selectedItem; // ลบ late และให้เป็น nullable
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width,
      height: Responsive.height * 0.15,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), color: Color.fromRGBO(42, 46, 48, 1)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // เพิ่ม padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ส่วนโปรไฟล์ผู้ใช้
              Expanded( // ใช้ Expanded แทน SizedBox
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    return Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.only(right: 8), 
                          decoration: BoxDecoration(color: Colors.white60, borderRadius: BorderRadius.circular(10)),
                          child: systemwidgetcustom.circleImageButton(userState.pic, 18, 50, () {}, 10),
                        ),
                        Expanded(child: Text(userState.display, style: Responsive.isTablet ? TextTheme.of(context).headlineMedium!.copyWith(fontWeight: FontWeight.w900, color: Colors.white) : TextTheme.of(context).titleLarge!.copyWith(fontWeight: FontWeight.w900, color: Colors.white), overflow: TextOverflow.ellipsis)),
                      ],
                    );
                  },
                ),
              ), 
              
              // ส่วนปุ่มแจ้งเตือนและเมนู
              Row(
                children: [
                  CircleIcon(
                    icon: Icon(Icons.notifications, color: Colors.white, size: Responsive.isTablet ? 35 : 30),
                    colorbg: greyOne,
                    padding: Responsive.isTablet ? 15 : 10,
                    function: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()))
                  ),
                  const SizedBox(width: 10),
                  PopupMenuButton<CustomPopupMenuItem>(
                    initialValue: _selectedItem,
                    color: Color.fromRGBO(115, 115, 119, 1),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.menu, color: Colors.white, size: Responsive.isTablet ? 35 : 30),
                    ),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<CustomPopupMenuItem>>[
                        CustomCustomPopupMenuItem(
                          value: CustomPopupMenuItem(
                            title: 'บัญชีผู้ใช้',
                            icon: Icons.person,
                            onTap: () {
                              Navigator.pop(context); // ปิด popup menu
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                            },
                          ),
                        ),
                        // เพิ่ม Divider ระหว่างเมนู
                        PopupMenuDivider(),
                        CustomCustomPopupMenuItem(
                          value: CustomPopupMenuItem(
                            title: 'ออกจากระบบ',
                            icon: Icons.logout,
                            onTap: () {
                              Navigator.pop(context); // ปิด popup menu
                              systemwidgetcustom.showDialogConfirm(context, 'ออกจากระบบ', 'ท่านต้องการออกจากระบบหรือไม่?', () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                // systemwidgetcustom.loadingWidget(context);
          
                                // // ออกจากระบบไปหน้าเข้าสู่ระบบ
                                // await configStorage.clearTokens();
                                // if (context.mounted) {
                                //   context.read<UsersBloc>().add(RemoveUser());
                                //   context.read<DevicesBloc>().add(ClearDevices());
                                //   Navigator.of(context).pop();
                                //   Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.login, (route) => false);
                                // }
                              }, Colors.blueGrey, Colors.red[400]!);
                            },
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// คลาส CustomPopupMenuItem สำหรับสร้างเมนูแบบป็อปอัพ
class CustomPopupMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap; // เปลี่ยนจาก Function() เป็น VoidCallback

  CustomPopupMenuItem({required this.title, required this.icon, required this.onTap});
}

// คลาส CustomCustomPopupMenuItem สำหรับแปลง CustomPopupMenuItem ให้เป็น PopupMenuEntry
class CustomCustomPopupMenuItem extends PopupMenuEntry<CustomPopupMenuItem> {
  final CustomPopupMenuItem value;

  const CustomCustomPopupMenuItem({super.key, required this.value});

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(CustomPopupMenuItem? value) => this.value == value;

  @override
  State createState() => _CustomCustomPopupMenuItemState();
}

class _CustomCustomPopupMenuItemState extends State<CustomCustomPopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return InkWell(
          onTap: widget.value.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(widget.value.icon, size: 20, color: themeState.themeApp ? Colors.white70 : Colors.lightBlue),
                const SizedBox(width: 12),
                Text(widget.value.title, style: TextTheme.of(context).titleMedium!.copyWith(color: themeState.themeApp ? Colors.white70 : Colors.lightBlue)),
              ],
            ),
          ),
        );
      },
    );
  }
}