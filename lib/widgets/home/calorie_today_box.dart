import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/theme/theme_bloc.dart';
import 'package:my_cal_track/bloc/user/user_bloc.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/services/exercise_formula.dart';
import 'package:my_cal_track/widgets/cusprogress_bar.dart';

class CalorieTodayBox extends StatelessWidget {
  const CalorieTodayBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Container(
          padding: const EdgeInsets.all(10),
          height: 200,
          decoration: BoxDecoration(
            color: themeState.themeApp ? cardBgColorDarkTheme : elementColorDarkTheme.withValues(alpha: 0.7), 
            borderRadius: BorderRadius.circular(20), 
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.4), // เงาสีเทาอ่อน
                blurRadius: 8,
                offset: Offset(0, 4)
              )
            ]
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, user) {
              // ทดสอบเปลี่ยนข้อมูล
              ExerciseFormula formula = ExerciseFormula();
              num bmr = formula.bmrCalculate(user.weight, user.height, user.age, user.gender);
              String activity = "Moderately active";
              double tdee = (formula.activiyCase(activity) * bmr);
              num protein = formula.calPotein(user.weight, activity);
              num fat = formula.calFat(tdee);
              num carbohydrate = formula.calCarbohydrate(tdee);
              if (kDebugMode) {
                print('------------------------------------------- bmr $bmr -------------------------------------');
                print('------------------------------------------- tdee $tdee -------------------------------------');
                print('------------------------------------------- protein $protein -------------------------------------');
                print('------------------------------------------- fat $fat -------------------------------------');
                print('------------------------------------------- carbohydrate $carbohydrate -------------------------------------');
              }

              context.read<UserBloc>().add(SetUser(tdee: tdee, maxProtien: protein, maxFat: fat, maxCabohydrate: carbohydrate));

              return user.loading ? Center(child: CircularProgressIndicator()) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('กินแล้ว', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: themeState.themeApp ? Colors.black45 : Colors.white)),
                          Text('${user.calories.toStringAsFixed(0)} Cals', style: TextTheme.of(context).titleMedium!.copyWith(color: themeState.themeApp ? Colors.black45 : Colors.white))
                        ],
                      ),
        
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox.expand(
                              child: CircularProgressIndicator(
                                value: 1.0,
                                strokeWidth: 10,
                                backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                                valueColor: AlwaysStoppedAnimation<Color>(const Color.fromRGBO(217, 217, 217, 1)),
                              ),
                            ),
                            SizedBox.expand(
                              child: CircularProgressIndicator(
                                value: user.calories != 0? user.calories / user.tdee : 0,
                                strokeWidth: 10,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(progressColorDarkTheme),
                              ),
                            ),
        
                            Text('${user.calories.toStringAsFixed(0)}\nCals', textAlign: TextAlign.center, style: TextTheme.of(context).headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: themeState.themeApp ? Colors.black45 : Colors.white))
                          ],
                        ),
                      ),
        
                      Column(
                        children: [
                          Text('TDEE', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: themeState.themeApp ? Colors.black45 : Colors.white)),
                          Text('${user.tdee.toStringAsFixed(0)} Cals', style: TextTheme.of(context).titleMedium!.copyWith(color: themeState.themeApp ? Colors.black45 : Colors.white))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      progressWidget(context, 'คาร์โบไฮเดรต', '${user.carbohydrate.toStringAsFixed(0)} / ${user.maxCabohydrate.toStringAsFixed(0)} กรัม',  (user.carbohydrate / user.maxCabohydrate) * 100),
                      progressWidget(context, 'โปรตีน', '${user.protien.toStringAsFixed(0)} / ${user.maxProtien.toStringAsFixed(0)} กรัม', (user.protien / user.maxProtien) * 100),
                      progressWidget(context, 'ไขมัน', '${user.fat.toStringAsFixed(0)} / ${user.maxFat.toStringAsFixed(0)} กรัม', (user.fat / user.maxFat) * 100),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget progressWidget(BuildContext context, String title, String detail, double progess) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: themeState.themeApp ? Colors.black45 : Colors.white)),
            CustomProgressBar(percentage: progess),
            Text(detail, style: TextTheme.of(context).titleMedium!.copyWith(color: themeState.themeApp ? Colors.black45 : Colors.white))
          ],
        );
      },
    );
  }
}