import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/exercises/exercises_event.dart';
import 'package:my_cal_track/bloc/exercises/exercises_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseState()) {
    on<GetExerciseList>((event, emit) {
      emit(state.copyWidth(
        exerciseList: event.exerciseList ?? [],
      ));
    });
  }
}
