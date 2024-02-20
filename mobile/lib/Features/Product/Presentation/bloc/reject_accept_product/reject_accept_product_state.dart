part of 'reject_accept_product_bloc.dart';


@immutable
abstract class RejectAcceptProductState extends Equatable {
  const RejectAcceptProductState();

  @override
  List<Object> get props => [];
}


final class RejectAcceptProductInitial extends RejectAcceptProductState {}

class LoadingRejectAcceptProductState extends RejectAcceptProductState {
  
}

class LoadedRequestProduct extends RejectAcceptProductState {
   final List<Product> product;

  LoadedRequestProduct({required this.product});

  @override
  List<Object> get props => [product];
}

class ErrorRequestProductState extends RejectAcceptProductState {
  final String message;

  ErrorRequestProductState({required this.message});

  @override
  List<Object> get props => [message];
}
