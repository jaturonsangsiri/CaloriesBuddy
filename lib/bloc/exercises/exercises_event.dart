import 'package:calories_buddy/models/exercise/exercise_response.dart';
import 'package:equatable/equatable.dart';

sealed class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class GetExerciseList extends ExerciseEvent {
  final Map<String, List<Exercise>>? exerciseList;

  const GetExerciseList({this.exerciseList});

  @override
  List<Object> get props => [exerciseList!];
}
