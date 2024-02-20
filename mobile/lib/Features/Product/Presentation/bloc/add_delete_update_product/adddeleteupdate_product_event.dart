part of 'adddeleteupdate_product_bloc.dart';

abstract class AdddeleteupdateProductEvent extends Equatable {
  const AdddeleteupdateProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends AdddeleteupdateProductEvent {
  final Product product;

  AddProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends AdddeleteupdateProductEvent {
  final Product product;

  UpdateProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends AdddeleteupdateProductEvent {
  final int ProductId;

  DeleteProductEvent({required this.ProductId});

  @override
  List<Object> get props => [ProductId];
}

class RejectProductEvent extends AdddeleteupdateProductEvent {
  final int ProductId;

  RejectProductEvent({required this.ProductId});

  @override
  List<Object> get props => [ProductId];
}

class AcceptProductEvent extends AdddeleteupdateProductEvent {
  final int ProductId;

  AcceptProductEvent({required this.ProductId});

  @override
  List<Object> get props => [ProductId];
}