part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class LoadingCategoryState extends CategoryState {
  
}
class LoadedCategory extends CategoryState {
  final List<Category> categorys;

  LoadedCategory({required this.categorys});

  @override
  List<Object> get props => [categorys];
}

class ErrorCategoryState extends CategoryState {
  final String message;

  ErrorCategoryState({required this.message});

  @override
  List<Object> get props => [message];
}
