import 'dart:ui';

// ignore_for_file: constant_identifier_names

// -------------------------------------  Colors --------------------------
Color backgroundColorTheme = const Color.fromRGBO(177, 177, 177, 1); // สีพื้นหลัง
Color backgroundColorDarkTheme = const Color.fromRGBO(46, 46, 46, 1); // สีพื้นหลัง
Color elementColor = const Color.fromRGBO(242, 187, 102, 1);
Color elementColorDarkTheme = const Color.fromRGBO(255, 107, 53, 1); // สีเน้นความเด่น เช่น พื้นหลังไอคอนที่กดได้ พื้นหลัง Banner ต่างๆ
Color progressColor = const Color.fromRGBO(255, 107, 83, 1);
Color progressColorDarkTheme = const Color.fromRGBO(247, 147, 38, 1); // สีของ ProgressBar Percen %
Color cardBgColor = const Color.fromRGBO(117, 117, 117, 1);
Color cardBgColorDarkTheme =  const Color.fromRGBO(117, 117, 117, 1); // สีพื้นหลังของ Card 
Color textColor = textColor;

Color greyOne = const Color.fromRGBO(158, 158, 158, 1); // สีตัวหนังสือ Grey 1 อ่อนสุด
Color greyTwo = const Color.fromRGBO(189, 189, 189, 1); // สีตัวหนังสือ Grey 2 อ่อน

List tagExercises = ['ทั้งหมด','อก','ไหล่','หน้าแขน','หลังแขน','ท่อนแขน','หลัง','ขา','น่อง'];
List tagMeals = ['ทั้งหมด','มื้อเช้า','มื้อกลางวัน','มื้อเย็น','มื้อว่าง','มื้อดึก'];

class URL {
  static const String BASE_URL = "https://tms.siamatic.co.th/smtrack";
  static const String DEFAULT_PIC = "https://drive.siamatic.co.th/media/image/default-pic.png";
}
