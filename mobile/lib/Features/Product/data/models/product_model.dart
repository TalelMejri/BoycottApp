import 'dart:io';

import 'package:mobile/Features/Product/domain/entities/Product.dart';

class ProductModel extends Product{

  const ProductModel({int? id, required String name, required File photo,required String description,required String id_categorie,int? products_count,String? user_id})
      : super(id: id, name: name, photo: photo, description: description, id_categorie: id_categorie);

   factory ProductModel.fromJson(Map<String,dynamic> json){
        return ProductModel(
          id: json['id'], 
          name: json['name'],
          photo: File(json['photo']),
          user_id:json['user_id'],
          description: json['description'],
          id_categorie: json['categorie_id'],
        );
   }

  Map<String, dynamic> toJson() {
    return {
        'id':id,
        'name': name, 
        'photo':photo.path, 
        'description': description,
        'categorie_id': id_categorie,
        "user_id":user_id
      };
  }

   @override
  String toString() {
    return 'Product {id: $id, name: $name, photo: '+photo.path+', description: $description, categorie_id: $id_categorie,user_id:$user_id}';
  }
 
}