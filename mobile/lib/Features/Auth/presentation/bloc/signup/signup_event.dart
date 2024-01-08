part of 'signup_bloc.dart';
abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class AddUserEvent extends SignupEvent {
  final LoginEntity user;

  AddUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class VerifyUserEvent extends SignupEvent {
  final String code;
  final String email;

  VerifyUserEvent({required this.code,required this.email});

  @override
  List<Object> get props => [code,email];
}