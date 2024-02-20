import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Product/domain/repositories/ProductRepository.dart';


class AcceptProductUsecase {
  final ProductRepository repository;

  AcceptProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.AcceptProduct(id);
  }
  
}