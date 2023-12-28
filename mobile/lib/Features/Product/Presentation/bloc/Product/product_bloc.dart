import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/Core/Strings/failures.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';
import 'package:mobile/Features/Product/domain/usecases/get_all.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final GetAllProductUsecase getAllProduct;
  
  ProductBloc({required this.getAllProduct}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetAllProductEvent) {
        emit(LoadingProductState());
        final furtureProduct = await getAllProduct(event.id_categorie);
        furtureProduct.fold((failure) {
          emit(ErrorProductState(message: _mapFailureToMessage(failure)));
        }, (products) {
          emit(LoadedProduct(products: products));
        });
      }
    });
  }
  
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
        case ServerFailure:
         return  SERVER_FAILURE_MESSAGE ;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure: 
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UKNOWN_FAILURE_MESSAGE;
    }
  }

}