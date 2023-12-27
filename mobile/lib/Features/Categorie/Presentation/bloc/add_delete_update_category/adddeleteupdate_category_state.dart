part of 'adddeleteupdate_category_bloc.dart';

abstract class AdddeleteupdateCategoryState extends Equatable {
  const AdddeleteupdateCategoryState();
  
  @override
  List<Object> get props => [];
}

class AdddeleteupdateCategoryInitial extends AdddeleteupdateCategoryState {}

class LoadingAddUpdateDeleteCategoryState extends AdddeleteupdateCategoryState {}

class ErrorAddUpdateDeleteCategoryState extends AdddeleteupdateCategoryState {
  final String message;

  ErrorAddUpdateDeleteCategoryState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateDeleteCategoryState extends AdddeleteupdateCategoryState {
  final String message;

  MessageAddUpdateDeleteCategoryState({required this.message});

  @override
  List<Object> get props => [message];
}
