import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/theme/theme_bloc.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/contants/date_time_constants.dart';
import 'package:my_cal_track/contants/muscle_icons.dart';
import 'package:my_cal_track/pages/exercise_page.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';

class ExerciseTablePage extends StatefulWidget {
  const ExerciseTablePage({super.key});

  @override
  State<ExerciseTablePage> createState() => _WeeklyWorkoutScreenState();
}

class _WeeklyWorkoutScreenState extends State<ExerciseTablePage> {
  // ข้อมูลรายการลิสออกกำลังกาย
  List<List<String>> exerciseDetails = [
    ['อก', 'หลัง'], 
    ['หลัง', 'แขน', 'ไหล่'], 
    ['พัก'], 
    ['ขา', 'หน้าท้อง'], 
    ['อก', 'หลัง'], 
    ['หลัง', 'แขน', 'ไหล่'], 
    ['พัก']
  ];
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();
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
        'video': 'assets/videos/pushup.mp4'
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
      _showRestDayDialog();
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
                        .map((entry) => _buildExerciseCard(entry.key, entry.value))
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

  void _showRestDayDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.grey[900]!,Colors.black87]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🌙 วันพักผ่อน', textAlign: TextAlign.center, style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white70, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('ให้ร่างกายได้ฟื้นฟูตัว', textAlign: TextAlign.center, style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 15),
                
                // Content with cards
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.grey[800]!.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[700]!, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('กิจกรรมแนะนำสำหรับวันนี้:', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      
                      // Activity items
                      _buildActivityItem('🚶‍♂️', 'เดินเล่นเบาๆ', 'ช่วยเพิ่มการไหลเวียนโลหิต'),
                      _buildActivityItem('🧘‍♀️', 'ยืดเส้นยืดสาย', 'ลดความตึงเครียดของกล้ามเนื้อ'),
                      _buildActivityItem('💆‍♂️', 'นวดกล้ามเนื้อ', 'ช่วยให้กล้ามเนื้อผ่อนคลาย'),
                      _buildActivityItem('💧', 'ดื่มน้ำเพียงพอ', 'ช่วยในการฟื้นฟูร่างกาย'),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                
                // Action buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: buttonColor1, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: Text('เข้าใจแล้ว', style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }

  void _playVideo(String videoPath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('เล่นวิดีโอ'),
        content: Text('จะเปิดวิดีโอ: $videoPath'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('ตกลง')),
        ],
      ),
    );
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
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.75),
                  itemCount: 7,
                  itemBuilder: (context, index) => _buildDayCard(index),
                ),
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
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isRestDay ? cardBgColorDarkTheme : elementColorDarkTheme, width: 1.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Day
                    Text(DateTimeConstants.DAYS_CONSTANT[dayIndex], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
                    // Status Indicator
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: isRestDay ? greyOne : elementColorDarkTheme, shape: BoxShape.circle))
                  ],
                ),
                SizedBox(height: 4),
                
                // Exercise Type/Rest Indicator
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: isRestDay ? themeState.themeApp ? backgroundColorDarkTheme : Colors.grey.shade800 : elementColorDarkTheme.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                  child: Text(isRestDay ? 'REST DAY' : 'WORKOUT', style: TextTheme.of(context).labelSmall!.copyWith(fontWeight: FontWeight.bold, color: isRestDay ? greyOne : elementColorDarkTheme, letterSpacing: 1)),
                ),
                const SizedBox(height: 4),
                
                // Main Content Area
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
                              
                              // Muscle Groups
                              Text(
                                exerciseDetails[dayIndex].take(2).join(' • '), 
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextTheme.of(context).bodyMedium!.copyWith(color: greyOne, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                
                // Action Buttons
                Column(
                  children: [
                    // View Details Button
                    GestureDetector(
                      onTap: () => _showDayDetail(dayIndex),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: themeState.themeApp ? backgroundColorDarkTheme : Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: cardBgColorDarkTheme,
                            width: 1,
                          ),
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

  Widget _buildExerciseCard(Map<String, dynamic> exercise, String muscle) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: themeState.themeApp ? cardBgColorDarkTheme : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: themeState.themeApp ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.2), width: 1),
          boxShadow: [
            BoxShadow(color: themeState.themeApp ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.08), spreadRadius: 0, blurRadius: 8, offset: Offset(0, 2))
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Exercise Image/Icon Container
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [elementColorDarkTheme.withValues(alpha: 0.8), elementColorDarkTheme], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: elementColorDarkTheme.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 4, offset: Offset(0, 2))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        exercise['image'],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Container(
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[100]),
                            child: Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null))
                          );
                        },
                        errorBuilder:(context, error, stackTrace) {
                          return Container(
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[100]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo, size: 40, color: Colors.grey[400]),
                                Text('No Image', style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.grey[400], fontWeight: FontWeight.w500))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exercise['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themeState.themeApp ? Colors.white : Colors.black87)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Image.asset(muscleIcons[muscle]!, color: themeState.themeApp ? Colors.white70 : Colors.grey[600], width: 20, height: 20, fit: BoxFit.cover),
                            SizedBox(width: 4),
                            Text('กล้ามเนื้อ$muscle', style: TextTheme.of(context).bodySmall!.copyWith(color: themeState.themeApp ? Colors.white70 : Colors.grey[600], fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: themeState.themeApp ? elementColorDarkTheme.withValues(alpha: 0.2) : elementColorDarkTheme.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                          child: Text('${exercise['sets']} เซ็ต × ${exercise['reps']} ${exercise['name'] == 'Plank' ? 'วินาที' : 'ครั้ง'}', style:  TextTheme.of(context).bodyMedium!.copyWith(color: themeState.themeApp ? elementColorDarkTheme.withValues(alpha: 0.9) : elementColorDarkTheme.withValues(alpha: 0.8), fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 16, color: themeState.themeApp ? Colors.white70 : Colors.grey[600]),
                            SizedBox(width: 4),
                            Text('พัก ${exercise['restTime']} วินาที', style: TextTheme.of(context).bodyMedium!.copyWith(color: themeState.themeApp ? Colors.white70 : Colors.grey[600], fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Video Play Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: themeState.themeApp ? 0.9 : 1.0),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.red.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 4, offset: Offset(0, 2))
                      ],
                    ),
                    child: IconButton(onPressed: () => _playVideo(exercise['video']!), icon: Icon(Icons.play_arrow, color: Colors.white, size: 24)),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Description Container
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeState.themeApp ? Colors.white.withValues(alpha: 0.05) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: themeState.themeApp ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.2), width: 1)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18, color: elementColorDarkTheme),
                    const SizedBox(width: 8),
                    Expanded(child: Text(exercise['description']!, style: TextTheme.of(context).bodyMedium!.copyWith(color: (themeState.themeApp ? Colors.white : Colors.black87).withValues(alpha: 0.8), height: 1.5))),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildActivityItem(String emoji, String title, String description) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.grey[700]!.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(emoji, style: TextTheme.of(context).titleLarge))),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextTheme.of(context).bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(description, style: TextTheme.of(context).labelLarge!.copyWith(color: Colors.grey[400]))
          ],
        ),
      ],
    ),
  );
}
}