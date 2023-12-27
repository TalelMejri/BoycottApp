part of 'adddeleteupdate_category_bloc.dart';

abstract class AdddeleteupdateCategoryEvent extends Equatable {
  const AdddeleteupdateCategoryEvent();

  @override
  List<Object> get props => [];
}

class AddCategoryEvent extends AdddeleteupdateCategoryEvent {
  final Category category;

  AddCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class UpdateCategoryEvent extends AdddeleteupdateCategoryEvent {
  final Category category;

  UpdateCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class DeleteCategoryEvent extends AdddeleteupdateCategoryEvent {
  final int categoryId;

  DeleteCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}