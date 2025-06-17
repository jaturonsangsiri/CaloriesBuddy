import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/widgets/icons_style.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';
import 'package:my_cal_track/widgets/utils/respone.dart';

class ExercisePage extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;

  const ExercisePage({super.key, required this.exercises});

  @override
  State<ExercisePage> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExercisePage> with TickerProviderStateMixin {
  int currentExerciseIndex = 0;
  int currentSet = 1;
  int completedSets = 0;
  bool isResting = false;
  bool isWorkoutStarted = false;
  bool isWorkoutCompleted = false;
  bool isWorkoutPaused = false;
  
  Timer? workoutTimer;
  Timer? restTimer;
  int workoutSeconds = 0;
  int restSeconds = 0;
  
  DateTime? workoutStartTime;
  List<Map<String, dynamic>> workoutHistory = [];
  
  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

  @override
  void initState() {
    super.initState();
    workoutStartTime = DateTime.now();
    
    // Initialize animations
    _pulseController = AnimationController(duration: Duration(seconds: 1), vsync: this)..repeat(reverse: true);
    _fadeController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();

    startWorkoutTimer();
  }

  @override
  void dispose() {
    workoutTimer?.cancel();
    restTimer?.cancel();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void startWorkoutTimer() {
    if (!isWorkoutStarted) {
      isWorkoutStarted = true;
      isWorkoutPaused = false;
      workoutTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            workoutSeconds++;
          });
        }
      });
    }
  }

  void pauseWorkoutTimer() {
    setState(() {
      isWorkoutPaused = true;
    });
    workoutTimer?.cancel();
    restTimer?.cancel();
  }

  void resumeworkoutTimer() {
    setState(() {
      isWorkoutStarted = false;
      isWorkoutPaused = false;
    });
    startWorkoutTimer();
    if (isResting && restSeconds > 0) {
      startRestTimer();
    }
  }

  void addTenSeconds() {
    if (restTimer != null && restTimer!.isActive) {
      restTimer!.cancel();
    }

    if (workoutTimer != null && workoutTimer!.isActive) {
      workoutTimer!.cancel();
    }

    setState(() {
      isResting = true;
      isWorkoutPaused = true;
      restSeconds += 10;
    });

    restTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (restSeconds > 0) {
            restSeconds--;
          } else {
            timer.cancel();
            isResting = false;
            restSeconds = 0;
            resumeworkoutTimer();
          }
        });
      }
    });
  }

  void goToPreviousExercise() {
    if (currentExerciseIndex > 0 || currentSet > 1) {
      setState(() {
        if (currentSet > 1) {
          // กลับไปยังเซ็ตก่อนหน้านี้
          currentSet--;
          if (completedSets > 0) completedSets--;
        } else if (currentExerciseIndex > 0) {
          // กลับไปยังท่าก่อนหน้านี้
          currentExerciseIndex--;
          currentSet = widget.exercises[currentExerciseIndex]['sets'];
          if (completedSets > 0) completedSets--;
        } 
        isResting = false;
        restTimer?.cancel();
        restSeconds = 0;
      });
    }
  }

  void skipCurrentExercise() {
    // ข้ามท่าออกกำลังกายในปัจจุบัน
    if (currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        // ข้ามไปยังท่าถัดไปผ
        currentExerciseIndex++;
        currentSet = 1;
        isResting = false;
        restTimer?.cancel();
        restSeconds = 0;
      });
    } else {
      // เป็นท่าสุดท้ายของการออกกำลังกาย
      _completeWorkout();
    }
  }

  void startRestTimer() {
    if (currentExerciseIndex < widget.exercises.length) {
      int restTime = widget.exercises[currentExerciseIndex]['restTime'];
      restSeconds = restTime;
      
      restTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted && !isWorkoutPaused) {
          setState(() {
            if (restSeconds > 0) {
              restSeconds--;
            } else {
              timer.cancel();
              isResting = false;
              restSeconds = 0;
            }
          });
        }
      });
    }
  }

  void completeSet() {
    setState(() {
      completedSets++;
      
      // บันทึกประวัติ
      workoutHistory.add({
        'exercise': widget.exercises[currentExerciseIndex]['name'],
        'set': currentSet,
        'reps': widget.exercises[currentExerciseIndex]['reps'],
        'timestamp': DateTime.now(),
      });

      if (currentSet < widget.exercises[currentExerciseIndex]['sets']) {
        // ยังมีเซ็ตต่อไป
        currentSet++;
        isResting = true;
        startRestTimer();
      } else {
        // จบแล้วทุกเซ็ตของท่านี้
        if (currentExerciseIndex < widget.exercises.length - 1) {
          // ยังมีท่าต่อไป
          currentExerciseIndex++;
          currentSet = 1;
          isResting = true;
          startRestTimer();
        } else {
          // จบแล้วทุกท่า
          _completeWorkout();
        }
      }
    });
  }

  void _completeWorkout() {
    workoutTimer?.cancel();
    restTimer?.cancel();
    
    setState(() {
      isWorkoutCompleted = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: cardBgColorDarkTheme,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: elementColorDarkTheme.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.emoji_events, color: progressColorDarkTheme, size: 32),
            ),
            const SizedBox(width: 15),
            Text('ยินดีด้วย!', style: TextTheme.of(context).headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('คุณออกกำลังกายเสร็จแล้ว!', style: TextTheme.of(context).titleMedium!.copyWith(color: greyTwo)),
            const SizedBox(height: 20),
            _buildDialogStat('⏱️', 'เวลาที่ใช้', _formatTime(workoutSeconds)),
            _buildDialogStat('💪', 'ท่าที่ทำ', '${widget.exercises.length} ท่า'),
            _buildDialogStat('🔥', 'เซ็ตที่ทำ', '$completedSets เซ็ต'),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: elementColorDarkTheme,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: Text('เสร็จสิ้น', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogStat(String emoji, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: TextTheme.of(context).titleMedium!.copyWith(fontSize: 18)),
          const SizedBox(width: 10),
          Text('$label: ', style: TextTheme.of(context).titleSmall!.copyWith(color: greyOne)),
          Text(value, style: TextTheme.of(context).titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (isWorkoutCompleted) {
      return Scaffold(
        appBar: systemwidgetcustom.appBarCustom(context, 'ออกกำลังกายเสร็จแล้ว', null, null),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: elementColorDarkTheme.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.check_circle, size: 80, color: progressColorDarkTheme)
              ),
              const SizedBox(height: 30),
              Text('ยินดีด้วย!', style: TextTheme.of(context).headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('คุณออกกำลังกายเสร็จแล้ว', style: TextTheme.of(context).titleMedium!.copyWith(color: greyTwo)),
            ],
          ),
        ),
      );
    }

    Map<String, dynamic> currentExercise = widget.exercises[currentExerciseIndex];
    
    return Scaffold(
      appBar: systemwidgetcustom.appBarCustom(context, 'ออกกำลังกาย', [
          Container(
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: elementColorDarkTheme.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer, color: progressColorDarkTheme, size: 18),
                const SizedBox(width: 6),
                Text(_formatTime(workoutSeconds), style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
        null
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Enhanced Progress Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: backgroundColorDarkTheme,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ท่าที่ ${currentExerciseIndex + 1}/${widget.exercises.length}', style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                        systemwidgetcustom.fullButon(context, 'เซ็ต $currentSet/${currentExercise['sets']}')
                      ],
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(value: (currentExerciseIndex + (currentSet - 1) / currentExercise['sets']) / widget.exercises.length, backgroundColor: cardBgColorDarkTheme, valueColor: AlwaysStoppedAnimation<Color>(progressColorDarkTheme)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Enhanced Exercise Card
              Container(
                width: double.infinity,
                height: 270,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: backgroundColorDarkTheme,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 2, blurRadius: 10, offset: Offset(0, 5))],
                ),
                child: Stack(
                  children: [
                    // Enhanced Exercise Icon
                    Positioned(
                      top: 10,
                      left: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 90,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [elementColorDarkTheme.withValues(alpha: 0.3), progressColorDarkTheme.withValues(alpha: 0.3)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: elementColorDarkTheme.withValues(alpha: 0.3), width: 2),
                            ),
                            child: ClipRRect(borderRadius: BorderRadius.circular(25), child: Image.network(currentExercise['image'], height: 80, width: 120, fit: BoxFit.cover))
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Exercise Name
                              Text(currentExercise['name'], style: TextTheme.of(context).titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              // Exercise Description
                              SizedBox(width: 220, child: Text(currentExercise['description'], maxLines: 3, overflow: TextOverflow.ellipsis, style: TextTheme.of(context).bodyMedium!.copyWith(color: Colors.white))),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Exercise Pictures info
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 120,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: currentExercise['images'].map<Widget>((image) => ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(
                            image, 
                            height: 120, 
                            width: 150, 
                            fit: BoxFit.fill,
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
                                    Icon(Icons.photo, size: 50, color: Colors.grey[400]),
                                    const SizedBox(height: 10),
                                    Text('No Image', style: TextTheme.of(context).bodyMedium!.copyWith(color: Colors.grey[400], fontWeight: FontWeight.w500))
                                  ],
                                ),
                              );
                            },
                          ))).toList(),
                        ),
                      ),
                    ),
                    
                    // Enhanced Set Info
                    Positioned(
                      top: 0,
                      right: 0,
                      child: systemwidgetcustom.fullButon(context, '${currentExercise['reps']} ${currentExercise['name'] == 'Plank' ? 'วินาที' : 'ครั้ง'}')
                    ),
                    const SizedBox(height: 25),
                    
                    // Enhanced Rest Timer
                    if (isResting) ...[
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Center(
                              child: Container(
                                height: 150,
                                padding: EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.withValues(alpha: 0.3),
                                      Colors.cyan.withValues(alpha: 0.3),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.cyan.withValues(alpha: 0.5),
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timer, size: 50, color: Colors.cyan),
                                    SizedBox(height: 5),
                                    Text('เวลาพัก', style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                                    Text('$restSeconds วินาที', style: TextTheme.of(context).headlineLarge!.copyWith(color: Colors.cyan, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Enhanced Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Video Button
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            height: Responsive.isTablet ? 400 : 300,
                            width: Responsive.isTablet ? 600 : 400,
                            decoration: BoxDecoration(color: cardBgColorDarkTheme, borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                // Header Row
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withValues(alpha: 0.2), 
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Icon(Icons.play_circle_fill, color: Colors.red, size: 24),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'เล่นวิดีโอ', 
                                      style: TextTheme.of(context).titleMedium!.copyWith(
                                        color: Colors.white, 
                                        fontSize: 18
                                      )
                                    ),
                                    Spacer(), // ใช้ Spacer ได้ใน Row หลัก
                                    CircleIcon(
                                      icon: Icon(
                                        Icons.close_rounded, 
                                        color: Colors.white, 
                                        size: Responsive.isTablet ? 35 : 30
                                      ),
                                      colorbg: greyOne,
                                      padding: Responsive.isTablet ? 15 : 10,
                                      function: () => Navigator.pop(context)
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 20),
                                
                                // Video Preview Container
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      width: 200,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.red.withValues(alpha: 0.3), 
                                            Colors.orange.withValues(alpha: 0.3)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.red.withValues(alpha: 0.3),
                                          width: 2
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.play_circle_fill,
                                        size: 60,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: IconText(
                      icon: Icons.play_circle_fill, 
                      text: 'ดูวิดีโอ', 
                      color: Colors.white, 
                      backgroundColor: Colors.red.shade600, 
                      size: 24, 
                      fontSize: 20
                    )
                  ),
                  const SizedBox(width: 15),
                  // Complete Set Button
                  GestureDetector(
                    onTap: (isResting || isWorkoutPaused) ? null : () {
                      startWorkoutTimer();
                      completeSet();
                    },
                    child: IconText(icon: (isResting || isWorkoutPaused) ? Icons.hourglass_empty : Icons.check_circle, text: (isResting || isWorkoutPaused) ? 'กำลังพัก...' : 'เสร็จเซ็ต', color: Colors.white, backgroundColor: (isResting || isWorkoutPaused) ? greyOne : elementColorDarkTheme, size: 24, fontSize: 20)
                  )
                ],
              ),
              const SizedBox(height: 15),
              
              // Enhanced Workout Stats
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: backgroundColorDarkTheme,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn('เวลาที่ใช้', _formatTime(workoutSeconds), Icons.timer, Colors.blue),
                    systemwidgetcustom.buildDivider(),
                    _buildStatColumn('เซ็ตที่ทำแล้ว', '$completedSets', Icons.fitness_center, elementColorDarkTheme),
                    systemwidgetcustom.buildDivider(),
                    _buildStatColumn('ท่าที่เหลือ', '${widget.exercises.length - currentExerciseIndex}', Icons.trending_down, progressColorDarkTheme),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Control Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: backgroundColorDarkTheme, 
                  borderRadius: BorderRadius.circular(16), 
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.2), spreadRadius: 1, blurRadius: 4, offset: Offset(0, 2))
                  ]
                ),
                child: Column(
                  children: [
                    // ปุ่มออกกำลังกายต่อ / หยุดออกกำลังกาย และเพิ่มเวลาพัก 10 วินาที
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ปุ่ม Play/Pause
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [ BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 1, blurRadius: 4, offset: Offset(0, 2)) ]),
                          child: FloatingActionButton(
                            heroTag: 'playPause',
                            onPressed: () {
                              if (isWorkoutPaused) {
                                resumeworkoutTimer();
                              } else {
                                pauseWorkoutTimer();
                              }
                            },
                            backgroundColor: isWorkoutPaused ? Colors.green : Colors.orange,
                            elevation: 0,
                            child: Icon(isWorkoutPaused ? Icons.play_arrow : Icons.pause, size: 30, color: Colors.white)
                          ),
                        ),

                        // ปุ่มเพิ่มเวลา 10 วินาที
                        GestureDetector(
                          onTap: addTenSeconds,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 1, blurRadius: 4, offset: Offset(0, 2))
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle_outline, size: 20, color: Colors.white),
                                Text('10s', style: TextTheme.of(context).bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                    
                        // Previous Exercise Button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 1, blurRadius: 4, offset: Offset(0, 2))
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: (currentExerciseIndex > 0 || currentSet > 1) ? goToPreviousExercise : null,
                            icon: Icon(Icons.skip_previous, size: 20),
                            label: Text('ย้อนกลับ'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (currentExerciseIndex > 0 || currentSet > 1) ? Colors.purple[600] : Colors.grey[600],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                          ),
                        ),
                        
                        // Skip Exercise Button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 1, blurRadius: 4, offset: Offset(0, 2))
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: skipCurrentExercise,
                            icon: Icon(Icons.skip_next, size: 20),
                            label: Text('ข้ามท่า'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 25),
        const SizedBox(height: 4),
        Text(label, style: TextTheme.of(context).bodySmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.white60)),
        const SizedBox(height: 2),
        Text(value, style: TextTheme.of(context).bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }
}