import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:com.talel.boycott/Core/Strings/failures.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/accept_reject_category/accept_category_bloc_bloc.dart';
import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/Accept_Product.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/Reject_Poduct.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/UpdateProduct.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/addProduct.dart';
import 'package:com.talel.boycott/Features/Product/domain/usecases/deleteProduct.dart';
part 'adddeleteupdate_product_event.dart';
part 'adddeleteupdate_product_state.dart';

class AdddeleteupdateProductBloc
    extends Bloc<AdddeleteupdateProductEvent, AdddeleteupdateProductState> {
  final AddProductUsecase addProduct;
  final UpdateProductUsecase updateProduct;
  final DeleteProductUsecase deleteProduct;
  final RejectProductUsecase rejectproduct;
  final AcceptProductUsecase acceptProduct;

  AdddeleteupdateProductBloc(
      {required this.addProduct,
      required this.updateProduct,
      required this.deleteProduct,
      required this.rejectproduct,
      required this.acceptProduct})
      : super(AdddeleteupdateProductInitial()) {
    on<AdddeleteupdateProductEvent>((event, emit) async {
      if (event is AddProductEvent) {
        emit(LoadingAddUpdateDeleteProductState());
        final failureOrDoneMessage = await addProduct(event.product);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "Product Add With Success"));
      } else if (event is UpdateProductEvent) {
        emit(LoadingAddUpdateDeleteProductState());
        final failureOrDoneMessage = await updateProduct(event.product);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "Product Updated With Success"));
      } else if (event is DeleteProductEvent) {
        emit(LoadingAddUpdateDeleteProductState());
        final failureOrDoneMessage = await deleteProduct(event.ProductId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "Product Deleted With Success"));
      } else if (event is AcceptProductEvent) {
        final failureOrDoneMessage = await acceptProduct(event.ProductId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "Product Updated With Success"));
      } else if (event is RejectProductEvent) {
        final failureOrDoneMessage = await rejectproduct(event.ProductId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, "Product Updated With Success"));
      }
    });
  }

  AdddeleteupdateProductState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddUpdateDeleteProductState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddUpdateDeleteProductState(message: message),
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
