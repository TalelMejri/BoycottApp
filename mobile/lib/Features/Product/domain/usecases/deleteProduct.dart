import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Features/Product/domain/repositories/ProductRepository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteProduct(id);
  }
  
}