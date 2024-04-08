import 'dart:io';

import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';

class ProductModel extends Product{

  const ProductModel({int? id, required String name, required File photo,required String description,required String id_categorie,int? products_count,String? user_id,required String code_fabricant})
      : super(id: id, name: name, photo: photo, description: description, id_categorie: id_categorie,code_fabricant: code_fabricant);

   factory ProductModel.fromJson(Map<String,dynamic> json){
        return ProductModel(
          id: json['id'], 
          name: json['name'],
          photo: File(json['photo']),
          user_id:json['user_id'],
          description: json['description'],
          id_categorie: json['categorie_id'],
          code_fabricant:json['code_fabricant']
        );
   }

  Map<String, dynamic> toJson() {
    return {
        'id':id,
        'name': name, 
        'photo':photo.path, 
        'description': description,
        'categorie_id': id_categorie,
        "user_id":user_id,
        "code_fabricant":code_fabricant
      };
  }

   @override
  String toString() {
    return 'Product {id: $id, name: $name, photo: '+photo.path+', description: $description, categorie_id: $id_categorie,user_id:$user_id ,code_fabricant:$code_fabricant}';
  }
 
}