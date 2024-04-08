import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:com.talel.boycott/Core/Strings/failures.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Auth/domain/entities/Payload.dart';
import 'package:com.talel.boycott/Features/Auth/domain/entities/login_entity.dart';
import 'package:com.talel.boycott/Features/Auth/domain/usecases/forget_password_user.dart';
import 'package:com.talel.boycott/Features/Auth/domain/usecases/reset_password_user.dart';
import 'package:com.talel.boycott/Features/Auth/domain/usecases/sign_up_user.dart';
import 'package:com.talel.boycott/Features/Auth/domain/usecases/verify_email_user.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {

  final VerifyEmailUseCase verifyEmailUseCase;
  final SignUpUserUseCase signUpUserUseCase;
  final ForgetPasswordUserUseCase forgetPasswordUseCase;
  final ResetPasswordUserUseCase resetPasswordUserUseCase;

  SignupBloc({
    required this.verifyEmailUseCase,
    required this.signUpUserUseCase,
    required this.forgetPasswordUseCase,
    required this.resetPasswordUserUseCase,
  }) : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
       if (event is AddUserEvent) {
        emit(LoadingSignupStateState());
        final failureOrDoneMessage = await signUpUserUseCase(event.user);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "User Add With Success"));
      }else if (event is VerifyUserEvent) {
        emit(LoadingSignupStateState());
        final failureOrDoneMessage = await verifyEmailUseCase(event.code,event.email);
        failureOrDoneMessage.fold((left) {
          emit(ErrorSignupStateState(message: _mapFailureToMessage(left)));
        }, (right) {
          emit(MessageSignupStateState(message: "Email Verified With Success"));
        });
      }
       else if (event is ResetPasswordEvent) {
        emit(LoadingSignupStateState());
        final failureOrDoneMessage = await resetPasswordUserUseCase(event.data);
        failureOrDoneMessage.fold((left) {
          emit(ErrorSignupStateState(message: _mapFailureToMessage(left)));
        }, (right) {
          emit(MessageSignupStateState(message: "Token Send"));
        });
      }
       else if (event is ForgetPasswordEvent) {
        emit(LoadingSignupStateState());
        final failureOrDoneMessage = await forgetPasswordUseCase(event.email);
        failureOrDoneMessage.fold((left) {
          emit(ErrorSignupStateState(message: _mapFailureToMessage(left)));
        }, (right) {
          emit(MessageSignupStateState(message: "Token Send"));
        });
      }
    });
  }

    SignupState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorSignupStateState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageSignupStateState(message: message),
    );
  }


   String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erreur inconnue. Veuillez réessayer plus tard";
    }
  }
}



