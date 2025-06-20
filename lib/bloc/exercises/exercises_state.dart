import 'package:equatable/equatable.dart';
import 'package:my_cal_track/models/exercise.dart';

class ExerciseState extends Equatable {
  final Map<String, List<Exercise>> exerciseList;
  const ExerciseState({
    this.exerciseList = const {}
  });

  ExerciseState copyWith({Map<String, List<Exercise>>? exerciseList}) {
    return ExerciseState(exerciseList: exerciseList ?? this.exerciseList);
  }

  @override
  List<Object> get props => [exerciseList];
}
