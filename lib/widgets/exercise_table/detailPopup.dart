import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/theme/theme_bloc.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/contants/muscle_icons.dart';
import 'package:my_cal_track/services/url_launcher.dart';

class DetailPopup extends StatelessWidget {
  final Map<String, dynamic> exercise;
  final String muscle;
  const DetailPopup({required this.exercise, required this.muscle, super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: IconButton(onPressed: () {
                      UrlLauncher urlLauncher = UrlLauncher();
                      urlLauncher.launchLink(exercise['video']!);
                    }, icon: Icon(Icons.play_arrow, color: Colors.white, size: 24)),
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
}