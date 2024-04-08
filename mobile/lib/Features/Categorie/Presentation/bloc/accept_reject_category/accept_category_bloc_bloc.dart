import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/usecases/accept_category.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/usecases/reject_category.dart';
import 'package:com.talel.boycott/Core/Strings/failures.dart';

part 'accept_category_bloc_event.dart';
part 'accept_category_bloc_state.dart';

class AcceptCategoryBlocBloc extends Bloc<AcceptCategoryBlocEvent, AcceptCategoryBlocState> {

  final AcceptCategoryUsecase acceptCategory;
  final RejectCategoryUsecase rejectCategory;

  AcceptCategoryBlocBloc(
    { 
      required this.acceptCategory,
      required this.rejectCategory,
    }
  ) : super(AcceptCategoryBlocInitial())  {
    on<AcceptCategoryBlocEvent>((event, emit) async {
      if (event is AcceptCategoryEvent) {
        emit(LoadingAcceptCategoryState());
        final failureOrDoneMessage = await acceptCategory(event.categoryId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "Accept Category"));
      }else if(event is RejectCategoryEvent){
          emit(LoadingAcceptCategoryState());
        final failureOrDoneMessage = await rejectCategory(event.categoryId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "Reject Category"));
      }
    });
  }


  AcceptCategoryBlocState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAcceptCategoryState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAcceptCategoryState(message: message),
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
