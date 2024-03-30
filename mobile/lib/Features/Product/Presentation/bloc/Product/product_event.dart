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


class CheckExisteProductEvent extends ProductEvent {
  final String code_fabricant;

  CheckExisteProductEvent({required this.code_fabricant});

  @override
  List<Object> get props => [code_fabricant];
}