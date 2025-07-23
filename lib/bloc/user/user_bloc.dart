import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:CaloriesBuddy/contants/contants.dart';
import 'package:CaloriesBuddy/configs/routes.dart' as custom_route;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  //final api = Api();
  UserBloc() : super(const UserState()) {
    on<SetUser>(_onSetUser);
    on<RemoveUser>(_onRemoveUser);
    on<SetError>(_onSetError);
  }

  void _onSetUser(SetUser event, Emitter<UserState> emit) async {
    try {
      //final user = await api.getUser();
      emit(state.copyWith(
        loading: event.loading,
        display: event.display, //user!.display,
        pic: event.pic, //user.pic,
        role: event.role, //user.role,
        id: event.id, // user.id,
        username: event.id,  //user.username
        carbohydrate: event.carbohydrate,  //user.carbohydrate
        maxCabohydrate: event.maxCabohydrate,  //user.maxCabohydrate
        protien: event.protien,  //user.protien
        maxProtien: event.maxProtien,  //user.maxProtien
        fat: event.fat,  //user.fat
        maxFat: event.maxFat,  //user.maxFat
        calories: event.calories,  //user.calories
        tdee: event.tdee,  //user.tdee
        weight: event.weight, //user.weight
        height: event.height, //user.height
        age: event.age, //user.age 
        gender: event.gender //user.gender
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
