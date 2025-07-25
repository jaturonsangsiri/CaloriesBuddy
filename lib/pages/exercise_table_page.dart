import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calories_buddy/bloc/theme/theme_bloc.dart';
import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/pages/exercise_page.dart';
import 'package:calories_buddy/widgets/exercise_table/restday_dialog.dart';
import 'package:calories_buddy/widgets/exercise_table/detail_popup.dart';
import 'package:calories_buddy/widgets/system_widget_custom.dart';

class ExerciseTablePage extends StatefulWidget {
  const ExerciseTablePage({super.key});

  @override
  State<ExerciseTablePage> createState() => _WeeklyWorkoutScreenState();
}

class _WeeklyWorkoutScreenState extends State<ExerciseTablePage> {
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();
  
  List<List<String>> exerciseDetails = [['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก'], ['ขา', 'หน้าท้อง'], ['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก']];
  // ข้อมูลรายละเอียดท่าออกกำลังกาย
  Map<String, List<Map<String, dynamic>>> exerciseList = {
    'อก': [
      {
        'name': 'Bench Press',
        'description': 'วิธีการ: การตั้งท่าที่มั่นคง วางเท้าให้ราบกับพื้น หลังแนบม้านั่ง จับบาร์กว้างกว่าไหล่เล็กน้อย และล็อคข้อมือให้ตรง',
        'sets': 4,
        'reps': 12,
        'restTime': 60,
        'image': 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        'images': ['https://cdn.mos.cms.futurecdn.net/v2/t:0,l:218,cw:563,ch:563,q:80,w:563/pLaRi5jXSHDKu6WRydetBo.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
        'video': 'https://www.youtube.com/watch?v=AJFf4ATImPA'
      },
      {
        'name': 'Cable Fly',
        'description': 'วิธีการ: กดด้ามจับสายเคเบิลให้มาอยู่ด้านหน้าหน้าอก โดยยืดแขนออกและให้ฝ่ามือหันเข้าหากัน จากนั้นเริ่มทำซ้ำโดยช้าๆ ให้ด้ามจับเคลื่อนไปทางเครื่องสายเคเบิลเป็นทิศทางโค้ง',
        'sets': 4,
        'reps': 12,
        'restTime': 60,
        'image': 'https://liftmanual.com/wp-content/uploads/2023/04/cable-standing-fly.jpg',
        'images': ['https://www.puregym.com/media/0c2ijzzq/cable-chest-flyes.jpg?quality=80', 'https://the-optimal-you.com/wp-content/uploads/2018/01/Cable-Fly.jpg'],
        'video': 'assets/videos/chest_press.mp4'
      }
    ],
    'หลัง': [
      {
        'name': 'Pull Up',
        'description': 'วิธีการ: ห้อยตัวบนบาร์ ดึงตัวขึ้นจนคางเกินบาร์',
        'sets': 3,
        'reps': 8,
        'restTime': 120,
        'image': 'https://anabolicaliens.com/cdn/shop/articles/199990_400x.png?v=1645089103',
        'images': ['https://liftmanual.com/wp-content/uploads/2023/04/reverse-grip-pull-up.jpg', 'https://rockrun.com/cdn/shop/articles/859664_1600x.jpg?v=1585560306'],
        'video': 'assets/videos/pullup.mp4'
      },
      {
        'name': 'T Bar Row',
        'description': 'วิธีการ: ยืนคร่อมบาร์ ก้มตัวลงเล็กน้อย และใช้มือทั้งสองข้างจับที่ปลายบาร์ จากนั้นยกน้ำหนักขึ้นโดยดึงบาร์เข้าหาลำตัว',
        'sets': 3,
        'reps': 12,
        'restTime': 90,
        'image': 'https://www.shutterstock.com/image-illustration/lever-tbar-row-plate-loaded-260nw-622379585.jpg',
        'images': ['https://watsongym.co.uk/wp-content/uploads/2023/03/DSC09119.jpg', 'https://cdn.shopify.com/s/files/1/0618/9462/3460/files/istockphoto-532792113-612x612-1.jpg'],
        'video': 'assets/videos/bent_row.mp4'
      }
    ],
    'แขน': [
      {
        'name': 'Bicep Curl',
        'description': 'วิธีการ: ยกดัมเบลขึ้นลงด้วยกล้ามเนื้อต้นแขน',
        'sets': 3,
        'reps': 15,
        'restTime': 60,
        'image': 'assets/images/exercises/bicep_curl.jpg',
        'images': ['https://www.shutterstock.com/image-illustration/dumbbell-biceps-curl-upper-arms-600nw-2327162897.jpg', 'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2017/11/1109-hammer-curl.jpg?quality=86&strip=all'],
        'video': 'assets/videos/bicep_curl.mp4'
      },
      {
        'name': 'Tricep Dip',
        'description': 'วิธีการ: วางมือบนเก้าอี้ ลดตัวลงแล้วดันขึ้น',
        'sets': 3,
        'reps': 12,
        'restTime': 90,
        'image': 'assets/images/exercises/tricep_dip.jpg',
        'images': ['https://images.squarespace-cdn.com/content/v1/5ffcea9416aee143500ea103/1638261887966-89KVMRDCF0WGGE7CH5YV/Assisted%2BTriceps%2BDips.jpeg', 'https://liftmanual.com/wp-content/uploads/2023/04/dumbbell-standing-triceps-extension.jpg', 'https://images.squarespace-cdn.com/content/v1/5ffcea9416aee143500ea103/1638260103209-NCDPK0RI94MTSL5YWMZM/One%2BArm%2BOverhead%2BStanding%2BTriceps%2BExtensions.jpeg'],
        'video': 'assets/videos/tricep_dip.mp4'
      }
    ],
    'ไหล่': [
      {
        'name': 'Lateral Dumbbell Raise',
        'description': 'วิธีการ: ยกดัมเบลขึ้นเหนือศีรษะ',
        'sets': 3,
        'reps': 12,
        'restTime': 90,
        'image': 'assets/images/exercises/shoulder_press.jpg',
        'images': ['https://kinxlearning.com/cdn/shop/files/exercise-32_1000x.jpg?v=1613157925', 'https://cdn.muscleandstrength.com/sites/default/files/one-arm-seated-dumbbell-lateral-raise.jpg'],
        'video': 'assets/videos/shoulder_press.mp4'
      }
    ],
    'ขา': [
      {
        'name': 'Squat',
        'description': 'วิธีการ: ยืนตรง นั่งลงแล้วลุกขึ้น',
        'sets': 3,
        'reps': 20,
        'restTime': 90,
        'image': 'assets/images/exercises/squat.jpg',
        'images': ['https://t4.ftcdn.net/jpg/00/89/03/89/360_F_89038937_M6GCms3m25qJyFuLRzudxCOSO6vc8BOK.jpg', 'https://hips.hearstapps.com/hmg-prod/images/man-training-with-weights-royalty-free-image-1718637105.jpg?crop=0.670xw:1.00xh;0.138xw,0&resize=1200:*'],
        'video': 'assets/videos/squat.mp4'
      },
      {
        'name': 'Lunges',
        'description': 'วิธีการ: ก้าวขาไปข้างหน้าแล้วลงลึก',
        'sets': 3,
        'reps': 15,
        'restTime': 90,
        'image': 'assets/images/exercises/lunges.jpg',
        'images': ['https://kinxlearning.com/cdn/shop/files/exercise-14_1000x.jpg?v=1613154730', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
        'video': 'assets/videos/lunges.mp4'
      }
    ],
    'หน้าท้อง': [
      {
        'name': 'Sit Up',
        'description': 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง',
        'sets': 3,
        'reps': 25,
        'restTime': 60,
        'image': 'assets/images/exercises/situp.jpg',
        'images': ['https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
        'video': 'assets/videos/situp.mp4'
      },
      {
        'name': 'Plank',
        'description': 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
        'sets': 3,
        'reps': 60,
        'restTime': 90,
        'image': 'assets/images/exercises/plank.jpg',
        'images': ['https://cdn.mos.cms.futurecdn.net/v2/t:0,l:218,cw:563,ch:563,q:80,w:563/pLaRi5jXSHDKu6WRydetBo.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
        'video': 'assets/videos/plank.mp4'
      }
    ]
  };

  void _showDayDetail(int dayIndex) {
    if (exerciseDetails[dayIndex].contains('พัก')) {
      Restdaydialog restdaydialog = Restdaydialog();
      restdaydialog.showRestDayDialog(context);
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.transparent,
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.fromLTRB(20, 16, 16, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: themeState.themeApp ? [elementColorDarkTheme.withValues(alpha: 0.8), elementColorDarkTheme] : [elementColorDarkTheme.withValues(alpha: 0.8), elementColorDarkTheme],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Drag Handle
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: themeState.themeApp ? Colors.white.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('วัน${DateTimeConstants.DAYS_CONSTANT[dayIndex]}', style: TextTheme.of(context).headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(exerciseDetails[dayIndex].join(' • '), style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Exercise List
              Expanded(
                child: Container(
                  color: themeState.themeApp ? backgroundColorDarkTheme : Colors.white,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: exerciseDetails[dayIndex]
                        .expand((muscle) => exerciseList[muscle]?.map((exercise) => 
                            MapEntry(exercise, muscle)) ?? <MapEntry<Map<String, dynamic>, String>>[])
                        .map((entry) => DetailPopup(exercise: entry.key, muscle: entry.value))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _startWorkout(int dayIndex) {
    List<Map<String, dynamic>> todayExercises = [];
    
    for (String muscle in exerciseDetails[dayIndex]) {
      if (exerciseList[muscle] != null) {
        todayExercises.addAll(exerciseList[muscle]!);
      }
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => ExercisePage(exercises: todayExercises)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: systemwidgetcustom.appBarCustom(context, 'ตารางการออกกำลังกาย', null, null),
      body: SafeArea(
        child: Column(
          children: [
            // Weekly Schedule Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.75),
                itemCount: 7,
                itemBuilder: (context, index) => _buildDayCard(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(int dayIndex) {
    bool isRestDay = exerciseDetails[dayIndex].contains('พัก');
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.4), spreadRadius: 0, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Container(
        decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: isRestDay ? cardBgColorDarkTheme : elementColorDarkTheme, width: 1.5)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateTimeConstants.DAYS_CONSTANT[dayIndex], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: isRestDay ? greyOne : elementColorDarkTheme, shape: BoxShape.circle))
                  ],
                ),
                SizedBox(height: 4),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: isRestDay ? themeState.themeApp ? backgroundColorDarkTheme : Colors.grey.shade800 : elementColorDarkTheme.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                  child: Text(isRestDay ? 'REST DAY' : 'WORKOUT', style: TextTheme.of(context).labelSmall!.copyWith(fontWeight: FontWeight.bold, color: isRestDay ? greyOne : elementColorDarkTheme, letterSpacing: 1)),
                ),
                const SizedBox(height: 4),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRestDay) 
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(color: themeState.themeApp ? backgroundColorDarkTheme : Colors.grey.shade800, borderRadius: BorderRadius.circular(6)),
                                child: Icon(Icons.self_improvement, size: 30, color: greyOne),
                              ),
                              const SizedBox(height: 4),
                              Text('วันพัก', style: TextTheme.of(context).bodyMedium!.copyWith(color: greyOne, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )
                      else
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Exercise Icons
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(color: themeState.themeApp ? backgroundColorDarkTheme : Colors.grey.shade800, borderRadius: BorderRadius.circular(6)),
                                child: Wrap(
                                  spacing: 3,
                                  runSpacing: 3,
                                  alignment: WrapAlignment.center,
                                  children: exerciseDetails[dayIndex].take(3).map((muscle) {
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(color: cardBgColorDarkTheme, borderRadius: BorderRadius.circular(3)),
                                      child: Image.asset(muscleIcons[muscle]!, color: elementColorDarkTheme, width: 20, height: 20, fit: BoxFit.cover),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(exerciseDetails[dayIndex].take(2).join(' • '), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextTheme.of(context).bodyMedium!.copyWith(color: greyOne, fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => _showDayDetail(dayIndex),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: themeState.themeApp ? backgroundColorDarkTheme : Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: cardBgColorDarkTheme, width: 1)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline, color: greyTwo, size: 18),
                            const SizedBox(width: 3),
                            Text('รายละเอียด', style: TextTheme.of(context).labelMedium!.copyWith(color: greyTwo, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    ),
                    
                    // Start Workout Button (only for workout days)
                    if (!isRestDay) ...[
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _startWorkout(dayIndex),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: elementColorDarkTheme,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(color: elementColorDarkTheme.withValues(alpha: 0.3), blurRadius: 3, offset: Offset(0, 1))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow, color: Colors.white, size: 18),
                              const SizedBox(width: 3),
                              Text('เริ่ม', style: TextTheme.of(context).labelMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.3)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            );
          }), 
        ),
      ),
    );
  }
}