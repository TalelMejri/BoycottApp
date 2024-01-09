part of 'signup_bloc.dart';
abstract class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class LoadingSignupStateState extends SignupState {}

class MessageSignupStateState extends SignupState {
  final String message;

  MessageSignupStateState({required this.message});

  @override
  List<Object> get props => [message];
}


class ErrorSignupStateState extends SignupState {
  final String message;

  ErrorSignupStateState({required this.message});

  @override
  List<Object> get props => [message];
}


class VerifyErrorSatet extends SignupState {
  final String message;

  VerifyErrorSatet({required this.message});

  @override
  List<Object> get props => [message];
}



