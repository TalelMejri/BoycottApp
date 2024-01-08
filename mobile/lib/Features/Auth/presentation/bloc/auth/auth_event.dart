part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginEntity user;
  LoginEvent({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class LogOutEvent extends AuthEvent {}