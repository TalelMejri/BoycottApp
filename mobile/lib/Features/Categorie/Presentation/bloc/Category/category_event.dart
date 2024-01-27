part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {

  const CategoryEvent();
  
  @override
  List<Object> get props => [];
}
class GetAllCategoryEvent extends CategoryEvent {}


class RefreshCategoryEvent extends CategoryEvent {}