import 'package:flutter/material.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  // ---------- ประกาศตัวแปร ----------
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

  // key ของตัวกรอกข้อมูล
  final _formKey = GlobalKey<FormState>();
  // controllers form
  TextEditingController setController = TextEditingController();
  TextEditingController countController = TextEditingController();
  // focus node
  FocusNode setFocus = FocusNode();
  FocusNode countFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text('จำนวนเซ็ต', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 6),
          systemwidgetcustom.normalTextFormField(controller: setController,hintText: 'จำนวนเซ็ต',keyboardType: TextInputType.number, focus: setFocus, hintColor: Colors.white),

          const SizedBox(height: 8),
          Text('จำนวนครั้ง', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 6),
          systemwidgetcustom.normalTextFormField(controller: countController,hintText: 'จำนวนครั้ง',keyboardType: TextInputType.number, focus: countFocus, hintColor: Colors.white),
          const SizedBox(height: 50),

          SizedBox(
            width: double.infinity, 
            height: 50, 
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(157, 119, 112, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), 
              onPressed: () {}, 
              child: Text('เพิ่มการออกกำลังกาย', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white))
            )
          )
        ],
      ),
    );
  }
}