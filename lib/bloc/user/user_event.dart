part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SetUser extends UserEvent {}

class SetError extends UserEvent {
  final bool error;
  const SetError(this.error);

  @override
  List<Object> get props => [error];
}

class RemoveUser extends UserEvent {}