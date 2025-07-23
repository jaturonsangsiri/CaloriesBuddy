import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:CaloriesBuddy/bloc/theme/theme_bloc.dart';
import 'package:CaloriesBuddy/contants/contants.dart';
import 'package:CaloriesBuddy/models/exercise.dart';
import 'package:CaloriesBuddy/models/food.dart';
import 'package:CaloriesBuddy/models/tag.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Systemwidgetcustom {
  // UI โหลดข้อมูล
  Future loadingWidget(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5), // พื้นหลังโปร่งใส
      builder: (context) {
        return Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 6.0),
          ),
        );
      },
    );
  }

  // แสดง Dialog ถามผู้ใช้มีตอบ ใช่หรือไม่
  Future showDialogConfirm(BuildContext context, String title, String? content, Function onConfirm, Color buttonColor, Color bnColortwo) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // ไม่ให้ปิด Dialog โดยการคลิกนอก Dialog
      builder: (context) {
        return Center(
          child: Container(
            height: 230,
            width: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: const Color.fromRGBO(130, 130, 130, 1), borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style:  TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: const Color.fromRGBO(190, 190, 190, 1), decoration: TextDecoration.none)),
                const SizedBox(height: 30),
                Text(content!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white,decoration: TextDecoration.none)),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(const Color.fromRGBO(130, 130, 130, 1)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white, width: 1))),
                        side: WidgetStateProperty.all<BorderSide>(BorderSide(color: buttonColor)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('ยกเลิก', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: buttonColor)),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(bnColortwo,), shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: bnColortwo, width: 1)))),
                      onPressed: () => onConfirm(),
                      child: Text('ตกลง', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ปุ่มสีพื้นหลังเต็มทั้งปุ่ม
  Widget fullButon(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: elementColorDarkTheme.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextTheme.of(context).titleMedium!.copyWith(color: progressColorDarkTheme, fontWeight: FontWeight.bold)),
    );
  }

  // ตัวหนังสือที่มีไอคอนอยู่ด้านหน้า
  Widget textWithIcon(IconData icon, String text, Color color, double size) {
    return Row(
      children: [
        Icon(icon, color: color, size: size * 1.5),
        const SizedBox(width: 5),
        Text(text, style: TextStyle(fontSize: size, color: color)),
      ],
    );
  }

  //รูปโปรไฟล์ วงกลมมีรูปภาพอยู่ด้านใน
  Widget circleImageButton(String picPath, double size, double picHeight, GestureTapCallback onTap, double radius,) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox.fromSize(
          size: Size.fromRadius(size),
          child: CachedNetworkImage(
            imageUrl: picPath,
            placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white70),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.fill,
            height: 50,
            scale: 0.7,
          ),
        ),
      ),
    );
  }

  // Widget TextFormField
  Widget normalTextFormField({required String hintText, required TextEditingController controller, required TextInputType keyboardType, required FocusNode focus, required Color hintColor}) {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      focusNode: focus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromRGBO(157, 119, 112, 1))),
      ),
    );
    
    // return BlocBuilder<ThemeBloc, ThemeState>(
    //   builder: (context, themeState) {
    //     return TextFormField(
    //       style: TextStyle(color: themeState.themeApp? Colors.white70 : Colors.black),
    //       focusNode: focus,
    //       controller: controller,
    //       keyboardType: keyboardType,
    //       decoration: InputDecoration(
    //         hintText: hintText,
    //         hintStyle: TextStyle(color: hintColor),
    //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    //         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: sixColor)),
    //       ),
    //     );
    //   },
    // );
  }

  // custom ListTile
  Widget customListTile(BuildContext context, Food food, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(166, 166, 166, 1), boxShadow: [BoxShadow(color: Colors.white, blurRadius: 1, offset: Offset(2, 2))], borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          children: [
            //Positioned(left: 10, top: 10, child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(food.image, fit: BoxFit.cover, width: 80, height: 80))),
            Positioned(left: 100, right: 50, top: 10, child: Text(food.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white))),
            Positioned(left: 100, right: 10, top: 35, child: Text(food.detail, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.white))),
            Positioned(right: 10, bottom: 10, child: GestureDetector(onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false, // ไม่ให้ปิด Dialog โดยการคลิกนอก Dialog
                builder: (context) {
                  // key ของตัวกรอกข้อมูล
                  final formKey = GlobalKey<FormState>();
                  // controllers form
                  TextEditingController plateController = TextEditingController();
                  // focus node
                  FocusNode plateFocus = FocusNode();

                  return AlertDialog(
                    backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                    content: SizedBox(
                      height: 570,
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('เพิ่มอาหาร', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1), decoration: TextDecoration.none)),
                          const SizedBox(height: 10),
                          ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(food.image, fit: BoxFit.cover, width: double.infinity, height: 150)),
                          const SizedBox(height: 6),
                    
                          Text('รายละเอียด', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text(food.detail, style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('แคลอรี่', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text('${food.calories} Cals', style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('คาร์โบไฮเดรต', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text('${food.carbohydrate} g', style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('โปรตีน', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text('${food.protein} g', style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('ไขมัน', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text('${food.fat} g', style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          // Text('แท็ก', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          // SizedBox(height: 6),
                          // Wrap(
                          //   spacing: 10,
                          //   runSpacing: 10,
                          //   children: [
                          //     for(Tag tg in food.tags)
                          //       tagCustom(tg, context, () {})
                          //   ]
                          // ),
                          // const SizedBox(height: 8),
                    
                          Text('จำนวนจาน', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          Form(
                            key: formKey,
                            child: normalTextFormField(controller: plateController,hintText: 'จำนวนจาน',keyboardType: TextInputType.number, focus: plateFocus, hintColor: const Color.fromRGBO(84, 84, 84, 1)),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(Color.fromRGBO(84, 84, 84, 1)),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white, width: 1))),
                              side: WidgetStateProperty.all<BorderSide>(BorderSide(color: Color.fromRGBO(84, 84, 84, 1))),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('ยกเลิก', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(const Color.fromRGBO(157, 119, 112, 1),), shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Color.fromRGBO(157, 119, 112, 1), width: 1)))),
                            onPressed: () {},
                            child: Text('ตกลง', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }, child: Container(width: 30, height: 30, decoration: BoxDecoration(color: Color.fromRGBO(52, 92, 114, 1), borderRadius: BorderRadius.circular(30)), child: Center(child: Icon(Icons.add, color: Colors.white, size: 20))))),
          ],
        ),
      ),
    );
  }

  // custom ListTile
  Widget customListTileExer(BuildContext context, Exercise exercise, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(166, 166, 166, 1), boxShadow: [BoxShadow(color: Colors.white, blurRadius: 1, offset: Offset(2, 2))], borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          children: [
            //Positioned(left: 10, top: 10, child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(exercise.image, fit: BoxFit.cover, width: 80, height: 80))),
            Positioned(left: 100, right: 50, top: 10, child: Text(exercise.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white))),
            Positioned(left: 100, right: 10, top: 35, child: Text(exercise.detail, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.white))),
            Positioned(right: 10, bottom: 10, child: GestureDetector(onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false, // ไม่ให้ปิด Dialog โดยการคลิกนอก Dialog
                builder: (context) {
                  // key ของตัวกรอกข้อมูล
                  final formKey = GlobalKey<FormState>();
                  // controllers form
                  TextEditingController setController = TextEditingController();
                  TextEditingController countController = TextEditingController();
                  // focus node
                  FocusNode setFocus = FocusNode();
                  FocusNode countFocus = FocusNode();

                  return AlertDialog(
                    backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                    content: SizedBox(
                      height: 570,
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ออกกำลังกาย', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1), decoration: TextDecoration.none)),
                          const SizedBox(height: 10),
                          ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(exercise.image, fit: BoxFit.cover, width: double.infinity, height: 150)),
                          const SizedBox(height: 6),
                    
                          Text('รายละเอียด', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text(exercise.detail, style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),

                          Text('กลุ่มกล้ามเนื้อ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text(exercise.muscle, style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('การเผาพลาญพลังงาน', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text('${exercise.calorieBurn} Cals', style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('ระดับ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text(difficultyExercise(exercise.difficulty), style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('อุปกรณ์ที่ใช้', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          SizedBox(height: 6),
                          Text(exercise.equipment, style: TextTheme.of(context).titleSmall!.copyWith(color: const Color.fromRGBO(84, 84, 84, 1))),
                          const SizedBox(height: 8),
                    
                          Text('จำนวนเซ็ต', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                normalTextFormField(controller: setController,hintText: 'จำนวนเซ็ต',keyboardType: TextInputType.number, focus: setFocus, hintColor: const Color.fromRGBO(84, 84, 84, 1)),

                                const SizedBox(height: 8),
                                Text('จำนวนครั้ง', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromRGBO(84, 84, 84, 1))),
                                normalTextFormField(controller: countController,hintText: 'จำนวนครั้ง',keyboardType: TextInputType.number, focus: countFocus, hintColor: const Color.fromRGBO(84, 84, 84, 1)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(Color.fromRGBO(84, 84, 84, 1)),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white, width: 1))),
                              side: WidgetStateProperty.all<BorderSide>(BorderSide(color: Color.fromRGBO(84, 84, 84, 1))),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('ยกเลิก', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(const Color.fromRGBO(157, 119, 112, 1),), shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Color.fromRGBO(157, 119, 112, 1), width: 1)))),
                            onPressed: () {},
                            child: Text('ตกลง', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }, child: Container(width: 30, height: 30, decoration: BoxDecoration(color: Color.fromRGBO(52, 92, 114, 1), borderRadius: BorderRadius.circular(30)), child: Center(child: Icon(Icons.add, color: Colors.white, size: 20))))),
          ],
        ),
      ),
    );
  }

  // Widget แท็ก
  Widget tagCustom(Tag tag, BuildContext context, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(color: tag.isPressed? Color.fromRGBO(166, 166, 166, 1) : Color.fromRGBO(222, 225, 235, 1), borderRadius: BorderRadius.circular(15), border: Border.all(color: Color.fromRGBO(222, 225, 235, 1), width: 2)),
        child: Text(tag.title, style: TextTheme.of(context).titleSmall!.copyWith(fontWeight: FontWeight.bold, color: tag.isPressed? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(115, 115, 115, 1))),
      ),
    );
  }

  String difficultyExercise(String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return 'เริ่มต้น';
      case 'intermediate':
        return 'ระดับกลาง';
      case 'advanced':
        return 'ระดับสูง';
      default:
        return 'ไม่ระบุ';
    }
  }

  AppBar appBarCustom(BuildContext context, String title, List<Widget>? actions, PreferredSize? buttom) {
    return AppBar(centerTitle: true, leading: Padding(
      padding: const EdgeInsets.only(left: 12),
        child: IconButton(
          padding: EdgeInsets.zero,
          iconSize: 20,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ), title: Text(title, style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white)),
      actions: actions,
      bottom: buttom
    );
  }

  Widget buildDivider() {
    return Container(height: 40, width: 1, decoration: BoxDecoration(color: greyOne));
  }

  Future<File?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source, maxHeight: 500, maxWidth: 500, imageQuality: 70);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Widget titleExpand(BuildContext context, String title, Widget page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white)),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
          style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text('ทั้งหมด', style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white)), const SizedBox(width: 4), BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) { return Icon(Icons.keyboard_arrow_down, color: themeState.themeApp ? Colors.black : Colors.white, size: 20); })],
          ),
        )
      ],
    );
  }
}

// สวิทซ์เลื่อนสร้างขึ้นเอง
class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color? thumbColor;
  final double width;
  final double height;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.deepOrange,
    this.inactiveColor = Colors.grey,
    this.thumbColor = Colors.white,
    this.width = 60,
    this.height = 30,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: value ? activeColor : inactiveColor),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: Duration(milliseconds: 250),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: height - 6,
                height: height - 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: thumbColor, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
