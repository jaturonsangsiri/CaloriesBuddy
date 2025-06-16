import 'package:equatable/equatable.dart';
import 'package:my_cal_track/models/exercise.dart';

sealed class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class GetExerciseList extends ExerciseEvent {
  final List<Exercise>? exerciseList;

  const GetExerciseList({this.exerciseList});

  @override
  List<Object> get props => [exerciseList!];
}
