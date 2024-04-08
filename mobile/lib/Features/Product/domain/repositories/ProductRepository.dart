import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import '../entities/Product.dart';

abstract class ProductRepository {

  Future<Either<Failure, List<Product>>> getAllProduct(int id_categorie);
  Future<Either<Failure, Unit>> deleteProduct(int id);
  Future<Either<Failure, Unit>> UpdateProduct(Product product);
  Future<Either<Failure, Unit>> AddProduct(Product product);
  Future<Either<Failure, List<Product>>> getAllRequestProduct(int id_categorie);
  Future<Either<Failure, Unit>> AcceptProduct(int id); 
  Future<Either<Failure, Unit>> RejectProduct(int id);
  Future<Either<Failure, Product>> CheckExisteProduct(String code_fabricant);
}