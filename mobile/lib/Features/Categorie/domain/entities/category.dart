import 'dart:io';

import 'package:equatable/equatable.dart';

class Category extends Equatable {
    final int? id;
    final String name;
    final File photo;
    final int? user_id;
    final int? products_count;

    const Category({
      this.id,
      this.user_id,
      required this.name,
      required this.photo,
      this.products_count
    });

    @override
    List<Object?> get props => [id,name,photo,products_count,user_id];

}