import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/configs/routes.dart' as custom_route;

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
        display: 'Jaturon sangsiri', //user!.display,
        pic: URL.DEFAULT_PIC, //user.pic,
        role: 'Admin', //user.role,
        id: '1', // user.id,
        username: 'jaturon1234',  //user.username
        carbohydrate: 23,  //user.carbohydrate
        maxCabohydrate: 200,  //user.maxCabohydrate
        protien: 12,  //user.protien
        maxProtien: 186,  //user.maxProtien
        fat: 8,  //user.fat
        maxFat: 60,  //user.maxFat
        calories: 150,  //user.calories
        maxCalories: 2300,  //user.maxCalories
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
      maxCalories: 0,
    ));
  }

  void _onSetError(SetError event, Emitter<UserState> emit) {
    emit(state.copyWith(error: event.error));
  }
}
