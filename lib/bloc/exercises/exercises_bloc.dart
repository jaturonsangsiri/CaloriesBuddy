import 'package:calories_buddy/services/api_service.dart';
import 'package:calories_buddy/services/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calories_buddy/bloc/exercises/exercises_event.dart';
import 'package:calories_buddy/bloc/exercises/exercises_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final api = APIService();
  final configStorage = ConfigStorage();

  ExerciseBloc() : super(const ExerciseState()) {
    on<GetExerciseList>(_onGetExercises);
  }

  void _onGetExercises(GetExerciseList event, Emitter<ExerciseState> emit) async {
    final exercises = await api.getExercises();
    emit(state.copyWith(exerciseList: exercises.exercisesData));
  }
}
