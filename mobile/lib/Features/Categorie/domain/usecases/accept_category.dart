import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Categorie/domain/repositories/CategoryRepository.dart';


class AcceptCategoryUsecase {
  final CategoryRepository repository;

  AcceptCategoryUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.AcceptCategory(id);
  }
  
}