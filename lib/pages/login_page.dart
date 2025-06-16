import 'package:flutter/material.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();
    return Scaffold(
      appBar: systemwidgetcustom.appBarCustom(context, 'เข้าสู่ระบบ', null, null),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            //Circu
          ],
        ),
      ),
    );
  }
}