import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:com.talel.boycott/Core/Strings/failures.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/CheckExisteCodeBar.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/get_all.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductUsecase getAllProduct;
  final CheckProductUsecase checkProduct;

  ProductBloc({required this.getAllProduct, required this.checkProduct})
      : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetAllProductEvent) {
        emit(LoadingProductState());
        final furtureProduct = await getAllProduct(event.id_categorie);
        furtureProduct.fold((failure) {
          emit(ErrorProductState(message: _mapFailureToMessage(failure)));
        }, (products) {
          emit(LoadedProduct(products: products));
        });
      } else if (event is CheckExisteProductEvent) {
        emit(LoadingCheckProductState());
        print("dsddddddddddd");
        final furtureProduct = await checkProduct(event.code_fabricant);
        print(furtureProduct);
        furtureProduct.fold((failure) {
          emit(ErrorProductState(message: _mapFailureToMessage(failure)));
        }, (product) {
          emit(LoadedProductExite(isExiste: product));
        });
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NotFound:
        return "Not Found";
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
