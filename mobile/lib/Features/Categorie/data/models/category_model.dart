import 'dart:io';

import 'package:mobile/Features/Categorie/domain/entities/category.dart';

class CategoryModel extends Category{

  const CategoryModel({int? id, required String name, required File photo,int? products_count,int? user_id})
      : super(id: id, name: name, photo: photo,products_count:products_count,user_id: user_id);

   factory CategoryModel.fromJson(Map<String,dynamic> json){
        return CategoryModel(
          id: json['id'], 
          name: json['name'],
          photo:File(json['photo']),
          user_id:json['user_id'],
          products_count:json['products_count'],
        );
   }

  Map<String, dynamic> toJson() {
    return {
        'id':id,
        'name': name, 
        'photo': photo.path, 
        "products_count":products_count,
        "user_id":user_id
      };
  }

   @override
  String toString() {
    return 'Category {id: $id, name: $name, photo: '+photo.path+',products_count:$products_count,user_id:$user_id';
  }
 
}