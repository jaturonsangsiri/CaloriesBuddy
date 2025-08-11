import 'package:flutter/material.dart';
import 'package:calories_buddy/widgets/system_widget_custom.dart';

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
  TextEditingController plateController = TextEditingController();
  // focus node
  FocusNode plateFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          systemwidgetcustom.normalTextFormField(controller: plateController,hintText: 'จำนวนกรัม',keyboardType: TextInputType.number, focus: plateFocus, hintColor: Colors.white),
          const SizedBox(height: 50),

          SizedBox(
            width: double.infinity, 
            height: 50, 
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(157, 119, 112, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), 
              onPressed: () {}, 
              child: Text('เพิ่มการกิน', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white))
            )
          )
        ],
      ),
    );
  }
}