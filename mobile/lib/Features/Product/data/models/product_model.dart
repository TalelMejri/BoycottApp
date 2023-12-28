import 'package:mobile/Features/Product/domain/entities/Product.dart';

class ProductModel extends Product{

  const ProductModel({int? id, required String name, required String photo,required String description,required int id_categorie})
      : super(id: id, name: name, photo: photo, description: description, id_categorie: id_categorie);

   factory ProductModel.fromJson(Map<String,dynamic> json){
        return ProductModel(
          id: json['id'], 
          name: json['name'],
          photo: json['photo'],
          description: json['description'],
          id_categorie: json['id_categorie']
        );
   }

  Map<String, dynamic> toJson() {
    return {
        'id':id,
        'name': name, 
        'photo': photo, 
        'description': description,
        'id_categorie': id_categorie
      };
  }

   @override
  String toString() {
    return 'Product {id: $id, name: $name, photo: $photo, description: $description, id_categorie: $id_categorie}';
  }
 
}