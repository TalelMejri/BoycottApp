part of 'reject_accept_product_bloc.dart';

@immutable
sealed class RejectAcceptProductEvent {
  const RejectAcceptProductEvent();
  
  @override
  List<Object> get props => [];
}



class GetAllRequestProductEvent extends RejectAcceptProductEvent {
  final int category_id;

  GetAllRequestProductEvent({required this.category_id});

  @override
  List<Object> get props => [category_id];
}


class RefreshRequestProductEvent extends RejectAcceptProductEvent {}

