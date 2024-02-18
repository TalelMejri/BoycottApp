part of 'request_category_bloc.dart';


@immutable
sealed class RequestCategoryEvent {

  const RequestCategoryEvent();
  
  @override
  List<Object> get props => [];
}

class GetAllRequestCategoryEvent extends RequestCategoryEvent {
  final int status;

  GetAllRequestCategoryEvent({required this.status});

  @override
  List<Object> get props => [status];
}


class RefreshRequestCategoryEvent extends RequestCategoryEvent {}
