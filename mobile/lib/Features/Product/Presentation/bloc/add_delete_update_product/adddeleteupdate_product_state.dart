part of 'adddeleteupdate_product_bloc.dart';

abstract class AdddeleteupdateProductState extends Equatable {
  const AdddeleteupdateProductState();
  
  @override
  List<Object> get props => [];
}

class AdddeleteupdateProductInitial extends AdddeleteupdateProductState {}

class LoadingAddUpdateDeleteProductState extends AdddeleteupdateProductState {}

class ErrorAddUpdateDeleteProductState extends AdddeleteupdateProductState {
  final String message;

  ErrorAddUpdateDeleteProductState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateDeleteProductState extends AdddeleteupdateProductState {
  final String message;

  MessageAddUpdateDeleteProductState({required this.message});

  @override
  List<Object> get props => [message];
}
