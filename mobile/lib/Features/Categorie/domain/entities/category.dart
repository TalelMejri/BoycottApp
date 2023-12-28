import 'package:equatable/equatable.dart';

class Category extends Equatable {
    final int? id;
    final String name;
    final String photo;
    final int? products_count;

    const Category({
      this.id,
      required this.name,
      required this.photo,
      this.products_count
    });

    @override
    List<Object?> get props => [id,name,photo,products_count];

}