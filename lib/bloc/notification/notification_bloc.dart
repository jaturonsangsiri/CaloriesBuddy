import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:CaloriesBuddy/models/notifications.dart';
import 'package:flutter/foundation.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  //final Api api = Api();
  NotificationBloc() : super(const NotificationState()) {
    on<GetAllNotifications>(_onLoadNotifications);
    on<NotificationError>(_onError);
  }

  void _onLoadNotifications(GetAllNotifications event, Emitter<NotificationState> emit) async {
     emit(state.copyWith(isLoading: true));
    try {
      List<NotificationModel> notifications = [];
      emit(state.copyWith(notifications: notifications, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isError: true, isLoading: false));
      if (kDebugMode) print(e);
    }
  }

  void _onError(NotificationError event, Emitter<NotificationState> emit) {
    emit(state.copyWith(isError: event.error));
  }
}
