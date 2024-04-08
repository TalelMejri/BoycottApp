import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/repositories/CategoryRepository.dart';
import 'package:dartz/dartz.dart';

class DeleteCategoryUsecase {
  final CategoryRepository repository;

  DeleteCategoryUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int CategoryId) async {
    return await repository.deleteCategory(CategoryId);
  }
  
}