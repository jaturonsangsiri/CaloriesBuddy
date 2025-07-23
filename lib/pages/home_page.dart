import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:CaloriesBuddy/bloc/exercises/exercises_bloc.dart';
import 'package:CaloriesBuddy/bloc/exercises/exercises_event.dart';
import 'package:CaloriesBuddy/bloc/exercises/exercises_state.dart';
import 'package:CaloriesBuddy/bloc/food/food_bloc.dart';
import 'package:CaloriesBuddy/bloc/meal/meal_bloc.dart';
import 'package:CaloriesBuddy/bloc/meal/meal_event.dart';
import 'package:CaloriesBuddy/bloc/meal/meal_state.dart';
import 'package:CaloriesBuddy/bloc/user/user_bloc.dart';
import 'package:CaloriesBuddy/contants/contants.dart';
import 'package:CaloriesBuddy/models/exercise.dart';
import 'package:CaloriesBuddy/models/food.dart';
import 'package:CaloriesBuddy/models/meals.dart';
import 'package:CaloriesBuddy/models/tag.dart';
import 'package:CaloriesBuddy/pages/exercise_detail_page.dart';
import 'package:CaloriesBuddy/pages/food_detail_page.dart';
import 'package:CaloriesBuddy/pages/item_list_page.dart';
import 'package:CaloriesBuddy/pages/exercise_table_page.dart';
import 'package:CaloriesBuddy/widgets/home/calorie_today_box.dart';
import 'package:CaloriesBuddy/widgets/home/header.dart';
import 'package:CaloriesBuddy/widgets/home/meal_box.dart';
import 'package:CaloriesBuddy/widgets/home/workout_table_week.dart';
import 'package:CaloriesBuddy/widgets/system_widget_custom.dart';

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
    context.read<UserBloc>().add(SetUser(
      loading: false,
      display: 'Jaturon sangsiri',
      pic: URL.DEFAULT_PIC, 
      role: 'Admin',
      id: '1',
      username: 'jaturon1234',
      calories: 0,
      tdee: 0,
      weight: 60,
      height: 167, 
      age: 25,
      gender: "ชาย"
    ));

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
    context.read<ExerciseBloc>().add(GetExerciseList(exerciseList: {
    'อก': [
        Exercise(name: 'Bench Press', detail: 'วิธีการ: การตั้งท่าที่มั่นคง วางเท้าให้ราบกับพื้น หลังแนบม้านั่ง จับบาร์กว้างกว่าไหล่เล็กน้อย และล็อคข้อมือให้ตรง', muscle: 'อก', image: 'https://c1e364f8.delivery.rocketcdn.me/wp-content/uploads/2023/07/%E0%B8%A7%E0%B8%B4%E0%B8%98%E0%B8%B5%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%97%E0%B8%B3%E0%B8%97%E0%B9%88%E0%B8%B2-BENCH-PRESS-%E0%B8%AD%E0%B8%A2%E0%B9%88%E0%B8%B2%E0%B8%87%E0%B8%96%E0%B8%B9%E0%B8%81%E0%B8%95%E0%B9%89%E0%B8%AD%E0%B8%87.jpg', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ปกติ', equipment: 'BarBell', sets: 4, reps: 12, images: ['https://c1e364f8.delivery.rocketcdn.me/wp-content/uploads/2023/07/%E0%B8%A7%E0%B8%B4%E0%B8%98%E0%B8%B5%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%97%E0%B8%B3%E0%B8%97%E0%B9%88%E0%B8%B2-BENCH-PRESS-%E0%B8%AD%E0%B8%A2%E0%B9%88%E0%B8%B2%E0%B8%87%E0%B8%96%E0%B8%B9%E0%B8%81%E0%B8%95%E0%B9%89%E0%B8%AD%E0%B8%87.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg']),
        Exercise(name: 'Dumbbell Fly Bench', detail: 'วิธีการ: นอนราบบนม้านั่ง จับดัมเบลด้วยมือทั้งสองข้างยกขึ้นเหนือหน้าอก และแขนเหยียดตรง จากนั้นค่อย ๆ ลดดัมเบลลงไปด้านหลังศีรษะ จนรู้สึกตึงที่กล้ามเนื้ออกและหลัง แล้วยกดัมเบลกลับขึ้นมาที่ท่าเริ่มต้น', muscle: 'อก', image: 'https://www.trainheroic.com/wp-content/uploads/2023/07/23076-TH-Blog-2400px-jpg.webp', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ปกติ', equipment: 'BarBell', sets: 4, reps: 12, images: ['https://cdn.mos.cms.futurecdn.net/v2/t:0,l:218,cw:563,ch:563,q:80,w:563/pLaRi5jXSHDKu6WRydetBo.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg']),
        Exercise(name: 'Cable Fly', detail: 'วิธีการ: กดด้ามจับสายเคเบิลให้มาอยู่ด้านหน้าหน้าอก โดยยืดแขนออกและให้ฝ่ามือหันเข้าหากัน จากนั้นเริ่มทำซ้ำโดยช้าๆ ให้ด้ามจับเคลื่อนไปทางเครื่องสายเคเบิลเป็นทิศทางโค้ง', muscle: 'อก', image: 'https://www.homefittools.com/pub/media/blog/dumbbell-fly-techniques-for-complete-chest-muscle-development.webp', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ง่าย', equipment: 'BarBell', sets: 4, reps: 12, images: ['https://www.homefittools.com/pub/media/blog/dumbbell-fly-techniques-for-complete-chest-muscle-development.webp', 'https://www.irontec.co/wp-content/uploads/2022/11/%E0%B8%97%E0%B9%88%E0%B8%B2-incline-bench-dumbbell-flyes-0-800x800.jpg'])
      ],
    'หลัง': [
      Exercise(name: 'Pull Up', detail: 'วิธีการ: ห้อยตัวบนบาร์ ดึงตัวขึ้นจนคางเกินบาร์', muscle: 'หลัง', image: 'https://anabolicaliens.com/cdn/shop/articles/199990_400x.png?v=1645089103', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ยาก', equipment: 'Bar Pull Up', sets: 3, reps: 8, images: ['https://liftmanual.com/wp-content/uploads/2023/04/reverse-grip-pull-up.jpg', 'https://rockrun.com/cdn/shop/articles/859664_1600x.jpg?v=1585560306']),
      Exercise(name: 'T Bar Row', detail: 'วิธีการ: ยืนคร่อมบาร์ ก้มตัวลงเล็กน้อย และใช้มือทั้งสองข้างจับที่ปลายบาร์ จากนั้นยกน้ำหนักขึ้นโดยดึงบาร์เข้าหาลำตัว', muscle: 'หลัง', image: 'https://www.shutterstock.com/image-illustration/lever-tbar-row-plate-loaded-260nw-622379585.jpg', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ยาก', equipment: 'T Bar', sets: 3, reps: 12, images: ['https://watsongym.co.uk/wp-content/uploads/2023/03/DSC09119.jpg', 'https://cdn.shopify.com/s/files/1/0618/9462/3460/files/istockphoto-532792113-612x612-1.jpg'])
    ],
    'แขน': [
      Exercise(name: 'Bicep Curl', detail: 'วิธีการ: ยกดัมเบลขึ้นลงด้วยกล้ามเนื้อต้นแขน', muscle: 'หน้าแขน', image: 'https://www.bpmuscle.com/admin/uploads/images/c8b6c652507d963a.png', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ง่าย', equipment: 'dumbbell', sets: 4, reps: 12, images: ['https://www.shutterstock.com/image-illustration/dumbbell-biceps-curl-upper-arms-600nw-2327162897.jpg', 'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2017/11/1109-hammer-curl.jpg?quality=86&strip=all']),
      Exercise(name: 'Tricep Dip', detail: 'วิธีการ: วางมือบนเก้าอี้ ลดตัวลงแล้วดันขึ้น', muscle: 'หน้าแขน', image: 'https://cdn.shopify.com/s/files/1/1497/9682/files/Benefits_of_Mastering_Tricep_Dips.jpg?v=1687254157&width=750', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ปานกลาง', equipment: 'dip', sets: 4, reps: 12, images: ['https://images.squarespace-cdn.com/content/v1/5ffcea9416aee143500ea103/1638261887966-89KVMRDCF0WGGE7CH5YV/Assisted%2BTriceps%2BDips.jpeg', 'https://liftmanual.com/wp-content/uploads/2023/04/dumbbell-standing-triceps-extension.jpg', 'https://images.squarespace-cdn.com/content/v1/5ffcea9416aee143500ea103/1638260103209-NCDPK0RI94MTSL5YWMZM/One%2BArm%2BOverhead%2BStanding%2BTriceps%2BExtensions.jpeg'])
    ],
    'ไหล่': [
      Exercise(name: 'Lateral Dumbbell Raise', detail: 'วิธีการ: ยืนตรงถือดัมเบลในมือแต่ละข้างปล่อยแขนลงข้างลำตัว จากนั้นยกแขนทั้งสองข้างออกด้านข้างพร้อมๆ กันจนขนานกับพื้นหรือสูงกว่าเล็กน้อย โดยให้ข้อศอกนำหน้า', muscle: 'ไหล่', image: 'https://images.squarespace-cdn.com/content/v1/55e406fbe4b0b03c5e7543ae/1492638807121-H3Q9V0YU7HX1Z9HJ48EQ/Standing+Dumbbell+Lateral+Raises', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ง่าย', equipment: 'dumbbell', sets: 4, reps: 12, images: ['https://kinxlearning.com/cdn/shop/files/exercise-32_1000x.jpg?v=1613157925', 'https://cdn.muscleandstrength.com/sites/default/files/one-arm-seated-dumbbell-lateral-raise.jpg'])
    ],
    'ขา': [
      Exercise(name: 'Squat', detail: 'วิธีการ: ยืนตรง นั่งลงแล้วลุกขึ้น', muscle: 'ขา', image: 'https://www.inspireusafoundation.org/wp-content/uploads/2022/06/the-barbell-squat.jpg', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ง่าย', equipment: 'barbell', sets: 3, reps: 15, images: ['https://t4.ftcdn.net/jpg/00/89/03/89/360_F_89038937_M6GCms3m25qJyFuLRzudxCOSO6vc8BOK.jpg', 'https://hips.hearstapps.com/hmg-prod/images/man-training-with-weights-royalty-free-image-1718637105.jpg?crop=0.670xw:1.00xh;0.138xw,0&resize=1200:*']),
      Exercise(name: 'Lunges', detail: 'วิธีการ: ก้าวขาไปข้างหน้าแล้วลงลึก', muscle: 'ขา', image: 'https://www.inspireusafoundation.org/wp-content/uploads/2022/06/the-barbell-squat.jpg', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ง่าย', equipment: 'barbell', sets: 3, reps: 15, images: ['https://kinxlearning.com/cdn/shop/files/exercise-14_1000x.jpg?v=1613154730', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'])
    ],
    'หน้าท้อง': [
      Exercise(name: 'Sit Up', detail: 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง', muscle: 'หน้าท้อง', image: 'https://liftmanual.com/wp-content/uploads/2023/04/incline-twisting-situp.jpg', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ง่าย', equipment: 'barbell', sets: 4, reps: 20, images: ['https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg']),
      Exercise(name: 'Plank', detail: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)', muscle: 'หน้าท้อง', image: 'https://www.inspireusafoundation.org/wp-content/uploads/2023/07/plank-benefits.png', video: 'https://www.youtube.com/watch?v=AJFf4ATImPA', difficulty: 'ง่าย', equipment: 'ไม่มี', sets: 4, reps: 12, images: ['https://cdn.mos.cms.futurecdn.net/v2/t:0,l:218,cw:563,ch:563,q:80,w:563/pLaRi5jXSHDKu6WRydetBo.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'])
    ]
  }
));

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