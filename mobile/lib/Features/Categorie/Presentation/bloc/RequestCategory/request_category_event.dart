part of 'request_category_bloc.dart';


@immutable
sealed class RequestCategoryEvent {

  const RequestCategoryEvent();
  
  @override
  List<Object> get props => [];
}

class GetAllRequestCategoryEvent extends RequestCategoryEvent {}


class RefreshRequestCategoryEvent extends RequestCategoryEvent {}
