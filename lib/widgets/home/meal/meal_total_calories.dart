import 'package:calories_buddy/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MealTotalCalories extends StatefulWidget {
  final String? mealId;
  const MealTotalCalories({super.key, this.mealId});

  @override
  State<MealTotalCalories> createState() => _MealTotalCaloriesState();
}

class _MealTotalCaloriesState extends State<MealTotalCalories> {
  double totalCalories = 0.0;
  APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    apiService.getTotalCalories(widget.mealId).then((totalCal) {
      if (mounted) {
        setState(() {
          totalCalories = totalCal;
        });
      }
    }).catchError((error) {
      if (kDebugMode) print('Error fetching total calories: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: Color.fromRGBO(60, 60, 60, 0.6), borderRadius: BorderRadius.circular(8), border: Border.all(color: Color.fromRGBO(80, 80, 80, 1),  width: 0.5)),
      child: Text('${totalCalories.ceil()} แคลอรี่', style: TextTheme.of(context).labelMedium!.copyWith(color: Colors.orange[300], fontWeight: FontWeight.w500))
    );
  }
}