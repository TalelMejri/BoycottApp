

import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';

abstract class CategoryRepository {

  Future<Either<Failure, List<Category>>> getAllcategories();
  Future<Either<Failure, Unit>> deleteCategory(int id);
  Future<Either<Failure, Unit>> UpdateCategory(Category category);
  Future<Either<Failure, Unit>> AddCategory(Category category);

}