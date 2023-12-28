import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';
import 'package:mobile/Features/Product/domain/repositories/ProductRepository.dart';


class UpdateProductUsecase {
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Product product) async {
    return await repository.UpdateProduct(product);
  }
  
}