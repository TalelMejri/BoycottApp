import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/repositories/CategoryRepository.dart';

class AddCategoryUsecase {
  final CategoryRepository repository;
  
  AddCategoryUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Category category) async {
    return await repository.AddCategory(category);
  }

}