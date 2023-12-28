part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {

   @override
   List<Object> get props => [];
}


class GetAllProductEvent extends ProductEvent {
  final int id_categorie;

  GetAllProductEvent({required this.id_categorie});

  @override
  List<Object> get props => [id_categorie];
}