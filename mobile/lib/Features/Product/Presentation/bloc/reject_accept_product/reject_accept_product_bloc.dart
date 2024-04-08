import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:com.talel.boycott/Core/Strings/failures.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/get_products_request.dart';

part 'reject_accept_product_event.dart';
part 'reject_accept_product_state.dart';

class RejectAcceptProductBloc extends Bloc<RejectAcceptProductEvent, RejectAcceptProductState> {
   final GetAllRequestProductUsecase getAllRequestProduct;
  RejectAcceptProductBloc({required this.getAllRequestProduct}) : super(RejectAcceptProductInitial()) {
    on<RejectAcceptProductEvent>((event, emit) async {
       if (event is GetAllRequestProductEvent) {
        emit(LoadingRejectAcceptProductState());
        final furtureProduct = await getAllRequestProduct(event.category_id);
        furtureProduct.fold((failure) {
          print("I failed");
          emit(ErrorRequestProductState(message: _mapFailureToMessage(failure)));
        }, (products) {
          print("I didn't fail");
          emit(LoadedRequestProduct(product: products));
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
