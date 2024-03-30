import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Core/network/network_info.dart';
import 'package:mobile/Features/Product/data/dataressource/product_remote_data_source.dart';
import 'package:mobile/Features/Product/data/dataressource/product_local_data_source.dart';
import 'package:mobile/Features/Product/data/models/product_model.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';
import 'package:mobile/Features/Product/domain/repositories/ProductRepository.dart';

typedef Future<Unit> DeleteOrUpdateOrAddProduct();

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Product>>> getAllProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await remoteDataSource.getAllProduct(id);
        localDataSource.cacheProduct(remoteCategory);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategory = await localDataSource.getCachedProduct();
        return Right(localCategory);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllRequestProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await remoteDataSource.getAllRequestProduct(id);
        localDataSource.cacheProduct(remoteCategory);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategory = await localDataSource.getCachedProduct();
        return Right(localCategory);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> AddProduct(Product product) async {
    final ProductModel productModel = ProductModel(
        name: product.name,
        photo: product.photo,
        description: product.description,
        id_categorie: product.id_categorie,
        code_fabricant: product.code_fabricant);
    return await _getMessage(() {
      return remoteDataSource.addProduct(productModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int ProductId) async {
    return await _getMessage(() {
      return remoteDataSource.deleteProduct(ProductId);
    });
  }

  @override
  Future<Either<Failure, Unit>> UpdateProduct(Product product) async {
    final ProductModel productModel = ProductModel(
        id: product.id,
        name: product.name,
        photo: product.photo,
        description: product.description,
        id_categorie: product.id_categorie,
        code_fabricant: product.code_fabricant);
    return await _getMessage(() {
      return remoteDataSource.updateProduct(productModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> AcceptProduct(int categoryId) async {
    return await _getMessage(() {
      return remoteDataSource.AccepetProduct(categoryId);
    });
  }

  @override
  Future<Either<Failure, Product>> CheckExisteProduct(
      String code_fabricant) async {
    try {
      final remoteProduct =
          await remoteDataSource.CheckExisteProductTest(code_fabricant);
          print(remoteProduct);
      return Right(remoteProduct);
    } on Exception {
      return Left(NotFound());
    }
  }

  @override
  Future<Either<Failure, Unit>> RejectProduct(int categoryId) async {
    return await _getMessage(() {
      return remoteDataSource.RejectProduct(categoryId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddProduct deleteOrUpdateOrAddProduct) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddProduct();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
