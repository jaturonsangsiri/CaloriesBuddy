import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/exercises/exercises_bloc.dart';
import 'package:my_cal_track/bloc/exercises/exercises_event.dart';
import 'package:my_cal_track/bloc/exercises/exercises_state.dart';
import 'package:my_cal_track/bloc/food/food_bloc.dart';
import 'package:my_cal_track/bloc/meal/meal_bloc.dart';
import 'package:my_cal_track/bloc/meal/meal_event.dart';
import 'package:my_cal_track/bloc/meal/meal_state.dart';
import 'package:my_cal_track/bloc/user/user_bloc.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/models/exercise.dart';
import 'package:my_cal_track/models/food.dart';
import 'package:my_cal_track/models/meals.dart';
import 'package:my_cal_track/models/tag.dart';
import 'package:my_cal_track/pages/exercise_detail_page.dart';
import 'package:my_cal_track/pages/food_detail_page.dart';
import 'package:my_cal_track/pages/item_list_page.dart';
import 'package:my_cal_track/pages/workout_table_page.dart';
import 'package:my_cal_track/widgets/home/calorie_today_box.dart';
import 'package:my_cal_track/widgets/home/header.dart';
import 'package:my_cal_track/widgets/home/meal_box.dart';
import 'package:my_cal_track/widgets/home/workout_table_week.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

  @override
  void initState() {
    super.initState();
    // เรียกใช้ Bloc เพื่อดึงข้อมูล
    context.read<UserBloc>().add(SetUser());

    // ดึงข้อมูลรายการอาหาร
    context.read<FoodBloc>().add(GetFoodList(foodList: [
      Food(name: 'ข้าวผัดไข่ มื้อเช้า', type: 'มื้อเช้า', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเช้า', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ มื้อกลางวัน', type: 'มื้อกลางวัน', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเช้า', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ มื้อเย็น', type: 'มื้อเย็น', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเย็น', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ มื้อดึก', type: 'มื้อดึก', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อกลางวัน', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ ของว่าง', type: 'ของว่าง', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อกลางวัน', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ วัตถุดิบ', type: 'วัตถุดิบ', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อกลางวัน', isPressed: true)])
    ], showList: [
      Food(name: 'ข้าวผัดไข่ มื้อเช้า', type: 'มื้อเช้า', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเช้า', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ มื้อกลางวัน', type: 'มื้อกลางวัน', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเช้า', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ มื้อเย็น', type: 'มื้อเย็น', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเย็น', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ มื้อดึก', type: 'มื้อดึก', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อกลางวัน', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ ของว่าง', type: 'ของว่าง', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อกลางวัน', isPressed: true)]),
      Food(name: 'ข้าวผัดไข่ วัตถุดิบ', type: 'วัตถุดิบ', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อกลางวัน', isPressed: true)])
    ]));

    // ดึงข้อมูลรายการออกกำลังกาย
    context.read<ExerciseBloc>().add(GetExerciseList(exerciseList: [
      Exercise(name: 'ท่าบริหารกล้ามเนื้อ',muscle: 'กล้ามเนื้อ',image: 'assets/images/bench-press.jpg',video: 'assets/video/exercise.mp4',detail: 'ท่าบริหารกล้ามเนื้อ 1',calorieBurn: 80,difficulty: 'beginner',equipment: 'ไม่มี'),
      Exercise(name: 'ท่าสควอท',muscle: 'ขา',image: 'assets/images/bench-press.jpg',video: 'assets/video/squat.mp4',detail: 'ท่าสควอทสำหรับกล้ามเนื้อขา',calorieBurn: 100,difficulty: 'beginner',equipment: 'ไม่มี'),
      Exercise(name: 'ท่าวิดพื้น',muscle: 'อก',image: 'assets/images/bench-press.jpg',video: 'assets/video/pushup.mp4',detail: 'ท่าวิดพื้นสำหรับกล้ามเนื้ออก',calorieBurn: 90,difficulty: 'beginner',equipment: 'ไม่มี'),
      Exercise(name: 'ท่าแพลงก์',muscle: 'แกนกลางลำตัว',image: 'assets/images/bench-press.jpg',video: 'assets/video/plank.mp4',detail: 'ท่าแพลงก์สำหรับกล้ามเนื้อแกนกลางลำตัว',calorieBurn: 70,difficulty: 'beginner',equipment: 'ไม่มี'),
    ]));

    // ดึงรายการมื้ออาหารของผู้ใช้
    context.read<MealBloc>().add(GetMealList(mealList: [
      Meals(name: 'มื้อเช้า', icon: Icons.wb_sunny, 
      foods: [
        Food(name: 'ข้าวผัดไข่ มื้อเช้า', type: 'มื้อเช้า', image: 'assets/images/food.jpg', detail: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carbohydrate: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเช้า', isPressed: true),Tag(title: 'มื้อกลางวัน', isPressed: true),Tag(title: 'มื้อเย็น', isPressed: true)]),
      ]),
      Meals(name: 'มื้อกลางวัน', icon: Icons.wb_cloudy, foods: []),
      Meals(name: 'มื้อเย็น', icon: Icons.nightlight_round, foods: []),
      Meals(name: 'มื้อว่าง', icon: Icons.coffee, foods: []),
      Meals(name: 'มื้อดึก', icon: Icons.bedtime, foods: []),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ประวัติวันนี้', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white)),
                  const SizedBox(height: 6),
                  CalorieTodayBox(),
                  const SizedBox(height: 10),

                  systemwidgetcustom.titleExpand(context, 'ตารางออกกำลังกาย', WorkoutTablePage()),
                  const SizedBox(height: 6),
                  WorkoutTableWeek(),
                  const SizedBox(height: 10),

                  systemwidgetcustom.titleExpand(context, 'รายการมื้อ', ItemListPage(title: 'มื้ออาหาร', tags: tagMeals.map((meal) { return meal == 'ทั้งหมด' ? Tag(title: meal, isPressed: true) : Tag(title: meal, isPressed: false); }).toList())),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 590,
                    child: BlocBuilder<MealBloc, MealState>(builder: (context, mealstate) {
                      final meals = mealstate.mealList;
                      return Column(
                        children: [
                          for(var meal in meals)
                            MealBox(meal: meal)
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                  
                  systemwidgetcustom.titleExpand(context, 'ท่าออกกำลังกาย', ItemListPage(title: 'ท่าออกกำลังกาย', tags: tagExercises.map((exer) { return exer == 'ทั้งหมด' ? Tag(title: exer, isPressed: true) : Tag(title: exer, isPressed: false); }).toList())),
                  const SizedBox(height: 10),
                  // ส่วนของรายการท่าออกกำลังกาย
                  SizedBox(
                    height: 350, // กำหนดความสูงที่ต้องการ
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      padding: EdgeInsets.zero,
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlocBuilder<ExerciseBloc, ExerciseState>(
                          builder: (context, exercise) {
                            return systemwidgetcustom.customListTileExer(
                              context,
                              exercise.exerciseList[index],
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseDetailPage(exercise: exercise.exerciseList[index])))
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  systemwidgetcustom.titleExpand(context, 'รายการอาหาร', ItemListPage(title: 'อาหาร', tags: tagMeals.map((meal) { return meal == 'ทั้งหมด' ? Tag(title: meal, isPressed: true) : Tag(title: meal, isPressed: false); }).toList())),
                  const SizedBox(height: 10),
                  // ส่วนของรายการอาหาร
                  SizedBox(
                    height: 350, // กำหนดความสูงชัดเจน
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      padding: EdgeInsets.zero,
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlocBuilder<FoodBloc, FoodState>(
                          builder: (context, foodState) {
                            return systemwidgetcustom.customListTile(
                              context,
                              foodState.foodList[index],
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: foodState.foodList[index]))),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}