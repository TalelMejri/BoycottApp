import 'package:equatable/equatable.dart';

class Product extends Equatable {
    final int? id;
    final String name;
    final String photo;
    final String description;
    final int id_categorie;


    const Product({
      this.id,
      required this.name,
      required this.photo,
      required this.description,
      required this.id_categorie,
   
    });

    @override
    List<Object?> get props => [id,name,photo,description,id_categorie];

}