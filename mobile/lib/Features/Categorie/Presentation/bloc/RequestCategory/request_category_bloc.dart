import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/Core/Strings/failures.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Categorie/domain/usecases/get_all_request.dart';
part 'request_category_event.dart';
part 'request_category_state.dart';

class RequestBloc extends Bloc<RequestCategoryEvent, RequestCategoryState> {
  final GetAllRequestUsecase getAllRequestCategory;

  RequestBloc({required this.getAllRequestCategory}) : super(RequestCategoryInitial()) {
    on<RequestCategoryEvent>((event, emit) async {
       if (event is GetAllRequestCategoryEvent) {
        emit(LoadingCategoryREquestState());
        final furtureCategory = await getAllRequestCategory(event.status);
        furtureCategory.fold((failure) {
          print("I failed");
          emit(ErrorRequestState(message: _mapFailureToMessage(failure)));
        }, (categorys) {
          print("I didn't fail");
          emit(LoadedRequest(categorys: categorys));
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
