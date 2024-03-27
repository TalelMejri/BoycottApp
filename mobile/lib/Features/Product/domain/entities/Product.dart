import 'dart:io';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
    final int? id;
    final String name;
    final File photo;
    final String description;
    final String? user_id;
    final String id_categorie;


    const Product({
      this.id,
      this.user_id,
      required this.name,
      required this.photo,
      required this.description,
      required this.id_categorie,
   
    });

    @override
    List<Object?> get props => [id,name,photo,description,id_categorie,user_id];

}