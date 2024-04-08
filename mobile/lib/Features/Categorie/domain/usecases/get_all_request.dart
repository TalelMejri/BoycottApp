import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/repositories/CategoryRepository.dart';
import 'package:dartz/dartz.dart';

class GetAllRequestUsecase {
  final CategoryRepository repository;

  GetAllRequestUsecase(this.repository);

  Future<Either<Failure, List<Category>>> call(int status) async {
    return await repository.getAllRequest(status);
  }
}
