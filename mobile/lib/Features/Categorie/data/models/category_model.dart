import 'package:mobile/Features/Categorie/domain/entities/category.dart';

class CategoryModel extends Category{

  const CategoryModel({int? id, required String name, required String photo})
      : super(id: id, name: name, photo: photo);

   factory CategoryModel.fromJson(Map<String,dynamic> json){
        return CategoryModel(
          id: json['id'], 
          name: json['name'],
          photo: json['photo'],
        );
   }

  Map<String, dynamic> toJson() {
    return {
        'id':id,
        'name': name, 
        'photo': photo, 
      };
  }

   @override
  String toString() {
    return 'Category {id: $id, name: $name, photo: $photo';
  }
 
}