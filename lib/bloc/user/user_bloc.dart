import 'package:calories_buddy/services/api_service.dart';
import 'package:calories_buddy/services/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/configs/routes.dart' as custom_route;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final api = APIService();
  final configStorage = ConfigStorage();
  
  UserBloc() : super(const UserState()) {
    on<SetUser>(_onSetUser);
    on<RemoveUser>(_onRemoveUser);
    on<SetError>(_onSetError);
  }

  void _onSetUser(SetUser event, Emitter<UserState> emit) async {
    try {
      final userId = await configStorage.getUserId();
      final user = await api.getUserProfile(userId!);
      emit(state.copyWith(
        loading: event.loading,
        display: user.data!.display,
        pic: user.data!.pic,
        role: user.data!.role,
        id: user.data!.id,
        username: user.data!.username,
        carbohydrate: user.data!.carbohydrate,
        maxCabohydrate: user.data!.maxCabohydrate,
        protien: user.data!.protien,
        maxProtien: user.data!.maxProtien,
        fat: user.data!.fat,
        maxFat: user.data!.maxFat,
        calories: user.data!.calories,
        tdee: user.data!.tdee,
        weight: user.data!.weight,
        height: user.data!.height,
        age: user.data!.age,
        gender: user.data!.gender
      ));
    } catch (e) {
      custom_route.Routes.navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  void _onRemoveUser(RemoveUser event, Emitter<UserState> emit) {
    emit(state.copyWith(
      display: '',
      pic: URL.DEFAULT_PIC,
      role: 'GUEST',
      id: '',
      username: '',
      error: false,
      carbohydrate: 0, 
      maxCabohydrate: 0,
      protien: 0,
      maxProtien: 0, 
      fat: 0, 
      maxFat: 0,
      calories: 0,
      tdee: 0,
    ));
  }

  void _onSetError(SetError event, Emitter<UserState> emit) {
    emit(state.copyWith(error: event.error));
  }
}
