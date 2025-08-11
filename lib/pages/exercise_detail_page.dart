import 'package:calories_buddy/models/exercise/exercise_response.dart';
import 'package:flutter/material.dart';
import 'package:calories_buddy/widgets/exercise/input.dart';
import 'package:calories_buddy/widgets/system_widget_custom.dart';

class ExerciseDetailPage extends StatelessWidget {  
  final Exercise exercise;                
  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();
    return Scaffold(
      appBar: systemwidgetcustom.appBarCustom(context, exercise.name!, null, null),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(exercise.image!, fit: BoxFit.cover, width: double.infinity, height: 250)),
              const SizedBox(height: 6),
        
              Text('รายละเอียด', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(exercise.detail!, style: TextTheme.of(context).titleSmall),
              const SizedBox(height: 8),

              Text('กลุ่มกล้ามเนื้อ', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(exercise.muscle!, style: TextTheme.of(context).titleSmall),
              const SizedBox(height: 8),
        
              Text('การเผาพลาญพลังงาน', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text('${exercise.calorieBurn} Cals', style: TextTheme.of(context).titleSmall),
              const SizedBox(height: 8),
        
              Text('ความยาก', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(systemwidgetcustom.difficultyExercise(exercise.difficulty!), style: TextTheme.of(context).titleSmall),
              const SizedBox(height: 8),
        
              Text('อุปกรณ์ที่ใช้', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(exercise.equipment!, style: TextTheme.of(context).titleSmall),
              const SizedBox(height: 8),
              Input(),
            ],
          ),
        ),
      ),
    );
  }
}