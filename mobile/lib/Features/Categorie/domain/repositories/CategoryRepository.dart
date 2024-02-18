import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import '../entities/category.dart';
abstract class CategoryRepository {

  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, Unit>> deleteCategory(int id);
  Future<Either<Failure, Unit>> UpdateCategory(Category category);
  Future<Either<Failure, Unit>> AddCategory(Category category);
  Future<Either<Failure, List<Category>>> getAllRequest(int status);
  Future<Either<Failure, Unit>> AcceptCategory(int id); 
  Future<Either<Failure, Unit>> RejectCategory(int id);
}