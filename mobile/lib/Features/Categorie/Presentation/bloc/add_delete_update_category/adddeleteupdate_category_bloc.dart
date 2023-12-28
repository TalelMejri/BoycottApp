import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/Core/Strings/failures.dart';
import 'package:mobile/Core/Strings/message.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Categorie/domain/usecases/UpdateCategory.dart';
import 'package:mobile/Features/Categorie/domain/usecases/addCategory.dart';
import 'package:mobile/Features/Categorie/domain/usecases/deleteCategory.dart';
part 'adddeleteupdate_category_event.dart';
part 'adddeleteupdate_category_state.dart';

class AdddeleteupdateCategoryBloc extends Bloc<AdddeleteupdateCategoryEvent, AdddeleteupdateCategoryState> {

  final AddCategoryUsecase addCategory;
  final UpdateCategoryUsecase updateCategory;
  final DeleteCategoryUsecase deleteCategory;

  AdddeleteupdateCategoryBloc(
   { required this.addCategory,
    required this.updateCategory,
    required this.deleteCategory}
  ) : super(AdddeleteupdateCategoryInitial()) {


    on<AdddeleteupdateCategoryEvent>((event, emit) async {
       if (event is AddCategoryEvent) {
        emit(LoadingAddUpdateDeleteCategoryState());
        final failureOrDoneMessage = await addCategory(event.category);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateCategoryEvent) {
          emit(LoadingAddUpdateDeleteCategoryState());
        final failureOrDoneMessage = await updateCategory(event.category);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeleteCategoryEvent) {
        emit(LoadingAddUpdateDeleteCategoryState());
        final failureOrDoneMessage = await deleteCategory(event.categoryId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

   AdddeleteupdateCategoryState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddUpdateDeleteCategoryState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddUpdateDeleteCategoryState(message: message),
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
