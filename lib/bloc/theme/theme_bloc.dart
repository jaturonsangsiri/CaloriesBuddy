import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:calories_buddy/services/preference.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final configStorage = ConfigStorage();
  ThemeBloc() : super(ThemeState()) {
    on<SetTheme>((event, emit) async {
      await configStorage.setTheme(!state.themeApp);
      emit(state.copyWith(themeApp: !state.themeApp));
    });

    on<InitTheme>((event, emit) {
      emit(state.copyWith(themeApp: event.theme));
    });
  }
}
