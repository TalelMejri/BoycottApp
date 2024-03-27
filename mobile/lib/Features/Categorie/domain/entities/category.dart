import 'dart:io';

import 'package:equatable/equatable.dart';

class Category extends Equatable {
    final int? id;
    final String name;
    final File photo;
    final String? user_id;
    final String? products_count;

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