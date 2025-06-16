part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final List<NotificationModel> notifications;
  final bool isError;
  final bool isLoading;
  const NotificationState({this.notifications = const [], this.isError = false, this.isLoading = true});
  
  NotificationState copyWith({List<NotificationModel>? notifications, bool? isError, bool? isLoading}) {
    return NotificationState(
      notifications: notifications ?? this.notifications, 
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  List<Object> get props => [notifications, isError, isLoading];
}
