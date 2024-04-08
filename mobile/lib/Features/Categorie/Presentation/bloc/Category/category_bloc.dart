import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:com.talel.boycott/Core/Strings/failures.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/usecases/get_all.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoryUsecase getAllCategory;

  CategoryBloc({required this.getAllCategory}) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
       if (event is GetAllCategoryEvent) {
        emit(LoadingCategoryState());
        final furtureCategory = await getAllCategory();
        furtureCategory.fold((failure) {
          print("I failed");
          emit(ErrorCategoryState(message: _mapFailureToMessage(failure)));
        }, (categorys) {
          print("I didn't fail");
          emit(LoadedCategory(categorys: categorys));
        });
      } 
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UKNOWN_FAILURE_MESSAGE;
    }
  }
}
