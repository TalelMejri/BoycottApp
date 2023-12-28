import 'package:mobile/Features/Categorie/domain/entities/category.dart';

class CategoryModel extends Category{

  const CategoryModel({int? id, required String name, required String photo,int? products_count})
      : super(id: id, name: name, photo: photo,products_count:products_count);

   factory CategoryModel.fromJson(Map<String,dynamic> json){
        return CategoryModel(
          id: json['id'], 
          name: json['name'],
          photo: json['photo'],
          products_count:json['products_count'],
        );
   }

  Map<String, dynamic> toJson() {
    return {
        'id':id,
        'name': name, 
        'photo': photo, 
        "products_count":products_count
      };
  }

   @override
  String toString() {
    return 'Category {id: $id, name: $name, photo: $photo,products_count:$products_count';
  }
 
}