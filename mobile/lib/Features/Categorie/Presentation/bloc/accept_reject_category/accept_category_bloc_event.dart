part of 'accept_category_bloc_bloc.dart';

abstract class AcceptCategoryBlocEvent extends Equatable {
  const AcceptCategoryBlocEvent();

  @override
  List<Object> get props => [];
}

class  AcceptCategoryEvent extends AcceptCategoryBlocEvent {
  final int categoryId;

  AcceptCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}


class  RejectCategoryEvent extends AcceptCategoryBlocEvent {
  final int categoryId;

  RejectCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}




