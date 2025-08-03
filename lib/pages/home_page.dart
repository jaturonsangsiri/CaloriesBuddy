import 'package:calories_buddy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calories_buddy/bloc/exercises/exercises_bloc.dart';
import 'package:calories_buddy/bloc/exercises/exercises_event.dart';
import 'package:calories_buddy/bloc/exercises/exercises_state.dart';
import 'package:calories_buddy/bloc/food/food_bloc.dart';
import 'package:calories_buddy/bloc/meal/meal_bloc.dart';
import 'package:calories_buddy/bloc/meal/meal_event.dart';
import 'package:calories_buddy/bloc/meal/meal_state.dart';
import 'package:calories_buddy/bloc/user/user_bloc.dart';
import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/models/food/food.dart';
import 'package:calories_buddy/models/meals.dart';
import 'package:calories_buddy/models/tag.dart';
import 'package:calories_buddy/pages/exercise_detail_page.dart';
import 'package:calories_buddy/pages/food_detail_page.dart';
import 'package:calories_buddy/pages/item_list_page.dart';
import 'package:calories_buddy/pages/exercise_table_page.dart';
import 'package:calories_buddy/widgets/home/calorie_today_box.dart';
import 'package:calories_buddy/widgets/home/header.dart';
import 'package:calories_buddy/widgets/home/meal_box.dart';
import 'package:calories_buddy/widgets/home/workout_table_week.dart';
import 'package:calories_buddy/widgets/system_widget_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();
  APIService apiService = APIService();

  void getData() async {
    if (mounted) {
      context.read<UserBloc>().add(GetUser());
      // ดึงข้อมูลรายการอาหาร
      context.read<FoodBloc>().add(SetFood());

      // ดึงข้อมูลรายการออกกำลังกาย
      context.read<ExerciseBloc>().add(GetExerciseList());
      // ดึงรายการมื้ออาหารของผู้ใช้
      context.read<MealBloc>().add(GetMealList(mealList: [
        Meals(name: 'มื้อเช้า', icon: Icons.wb_sunny, 
        foods: [
          Food(name: 'ข้าวผัดไข่ มื้อเช้า', type: 'มื้อเช้า', image: 'assets/images/food.jpg', description: 'ข้าวสวย 80 กรัม อกไก่ 100 กรัม ไข่ไก่ต้ม 3 ฟอง', calories: 630, carb: 56, protein: 28, fat: 20, tags: [Tag(title: 'มื้อเช้า', isPressed: true),Tag(title: 'มื้อกลางวัน', isPressed: true),Tag(title: 'มื้อเย็น', isPressed: true)]),
        ]),
        Meals(name: 'มื้อกลางวัน', icon: Icons.wb_cloudy, foods: []),
        Meals(name: 'มื้อเย็น', icon: Icons.nightlight_round, foods: []),
        Meals(name: 'มื้อว่าง', icon: Icons.coffee, foods: []),
        Meals(name: 'มื้อดึก', icon: Icons.bedtime, foods: []),
      ]));
    }
  }

  

  @override
  void initState() {
    super.initState();
    getData();
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

                  systemwidgetcustom.titleExpand(context, 'ตารางออกกำลังกาย', ExerciseTablePage()),
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
                              exercise.exerciseList['อก']![index],
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseDetailPage(exercise: exercise.exerciseList[exerciseContant[0]]![index])))
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
                            return foodState.foodList.isNotEmpty? systemwidgetcustom.customListTile(
                              context,
                              foodState.foodList[index],
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: foodState.foodList[index]))),
                            ) : Text('กำลังโหลดข้อมูลอาหาร...');
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