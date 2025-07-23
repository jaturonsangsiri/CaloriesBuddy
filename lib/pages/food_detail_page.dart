import 'package:flutter/material.dart';
import 'package:CaloriesBuddy/models/food.dart';
import 'package:CaloriesBuddy/models/tag.dart';
import 'package:CaloriesBuddy/widgets/food/input.dart';
import 'package:CaloriesBuddy/widgets/system_widget_custom.dart';

class FoodDetailPage extends StatelessWidget {  
  final Food food;                
  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();
    return Scaffold(
      appBar: systemwidgetcustom.appBarCustom(context, food.name, null, null),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(food.image, fit: BoxFit.cover, width: double.infinity, height: 250)),
              const SizedBox(height: 6),
        
              Text('รายละเอียด', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(food.detail, style: TextTheme.of(context).titleSmall!),
              const SizedBox(height: 8),
        
              Text('แคลอรี่', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text('${food.calories} Cals', style: TextTheme.of(context).titleSmall!),
              const SizedBox(height: 8),
        
              Text('คาร์โบไฮเดรต', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text('${food.carbohydrate} g', style: TextTheme.of(context).titleSmall!),
              const SizedBox(height: 8),
        
              Text('โปรตีน', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text('${food.protein} g', style: TextTheme.of(context).titleSmall!),
              const SizedBox(height: 8),
        
              Text('ไขมัน', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text('${food.fat} g', style: TextTheme.of(context).titleSmall!),
              const SizedBox(height: 8),
        
              Text('แท็ก', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for(Tag tg in food.tags)
                    systemwidgetcustom.tagCustom(tg, context, () {})
                ]
              ),
              const SizedBox(height: 8),
              Text('จำนวนจาน', style: TextTheme.of(context).titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Input(),
            ],
          ),
        ),
      ),
    );
  }
}