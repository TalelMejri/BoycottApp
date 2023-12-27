import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Categorie/domain/repositories/CategoryRepository.dart';
import 'package:dartz/dartz.dart';

class GetAllCategoryUsecase {
  final CategoryRepository repository;

  GetAllCategoryUsecase(this.repository);

  Future<Either<Failure, List<Category>>> call() async {
    return repository.getAllcategories();
  }
}
