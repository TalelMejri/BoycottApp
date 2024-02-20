part of 'request_category_bloc.dart';

@immutable
abstract class RequestCategoryState extends Equatable {
  const RequestCategoryState();

  @override
  List<Object> get props => [];
}

final class RequestCategoryInitial extends RequestCategoryState {}


class LoadingCategoryREquestState extends RequestCategoryState {
  
}

class LoadedRequest extends RequestCategoryState {
   final List<Category> categorys;

  LoadedRequest({required this.categorys});

  @override
  List<Object> get props => [categorys];
}

class ErrorRequestState extends RequestCategoryState {
  final String message;

  ErrorRequestState({required this.message});

  @override
  List<Object> get props => [message];
}
