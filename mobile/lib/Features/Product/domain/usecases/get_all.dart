import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';
import 'package:com.talel.boycott/Features/Product/domain/repositories/ProductRepository.dart';

class GetAllProductUsecase {
  final ProductRepository repository;

  GetAllProductUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call(int id_categorie) async {
    return await repository.getAllProduct(id_categorie);
  }
}
