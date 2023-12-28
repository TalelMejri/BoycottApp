import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import '../entities/Product.dart';

abstract class ProductRepository {

  Future<Either<Failure, List<Product>>> getAllProduct(int id_categorie);
  Future<Either<Failure, Unit>> deleteProduct(int id);
  Future<Either<Failure, Unit>> UpdateProduct(Product product);
  Future<Either<Failure, Unit>> AddProduct(Product product);

}