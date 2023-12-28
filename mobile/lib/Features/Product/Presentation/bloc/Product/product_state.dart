part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}


class LoadingProductState extends ProductState {
  
}

class LoadedProduct extends ProductState {
  final List<Product> products;

  LoadedProduct({required this.products});

  @override
  List<Object> get props => [products];
}

class ErrorProductState extends ProductState {
  final String message;

  ErrorProductState({required this.message});

  @override
  List<Object> get props => [message];
}
