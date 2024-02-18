part of 'accept_category_bloc_bloc.dart';


abstract class AcceptCategoryBlocState extends Equatable {
  const AcceptCategoryBlocState();
  
  @override
  List<Object> get props => [];
}

final class AcceptCategoryBlocInitial extends AcceptCategoryBlocState {}

class LoadingAcceptCategoryState extends AcceptCategoryBlocState {}


class ErrorAcceptCategoryState extends AcceptCategoryBlocState {
  final String message;

  ErrorAcceptCategoryState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAcceptCategoryState extends AcceptCategoryBlocState {
  final String message;

  MessageAcceptCategoryState({required this.message});

  @override
  List<Object> get props => [message];
}
