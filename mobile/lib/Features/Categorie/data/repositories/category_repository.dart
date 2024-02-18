import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Core/network/network_info.dart';
import 'package:mobile/Features/Categorie/data/dataressource/category_local_data_source.dart';
import 'package:mobile/Features/Categorie/data/dataressource/category_remote_data_source.dart';
import 'package:mobile/Features/Categorie/data/models/category_model.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Categorie/domain/repositories/CategoryRepository.dart';


typedef Future<Unit> DeleteOrUpdateOrAddCategory();

class CategoryRepositoryImpl implements CategoryRepository {

  final CatyegoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
      {
        required this.remoteDataSource,
        required this.localDataSource,
        required this.networkInfo
      }
  );

   @override
   Future<Either<Failure, List<Category>>> getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await remoteDataSource.getAllCategory();
        localDataSource.cachecategory(remoteCategory);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategory = await localDataSource.getCachedCategory();
        return Right(localCategory);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
@override
Future<Either<Failure, List<Category>>> getAllRequest(int status) async{
  if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await remoteDataSource.getAllRequest(status);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
        return Left(EmptyCacheFailure());
    }
}

  @override
  Future<Either<Failure, Unit>> AddCategory(Category category) async {
    final CategoryModel categoryModel = CategoryModel(name: category.name, photo: category.photo);
    return await _getMessage(() {
      return remoteDataSource.addCategory(categoryModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(int categoryId) async {
    return await _getMessage(() {
      return remoteDataSource.deleteCategory(categoryId);
    });
  }


   @override
  Future<Either<Failure, Unit>> AcceptCategory(int categoryId) async {
    return await _getMessage(() {
      return remoteDataSource.AccepetCategory(categoryId);
    });
  }

   @override
  Future<Either<Failure, Unit>> RejectCategory(int categoryId) async {
    return await _getMessage(() {
      return remoteDataSource.RejectCategory(categoryId);
    });
  }

  @override
  Future<Either<Failure, Unit>> UpdateCategory(Category category) async {
    final CategoryModel categoryModel = CategoryModel(id:category.id,name: category.name, photo: category.photo);
    return await _getMessage(() {
      return remoteDataSource.updateCategory(categoryModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddCategory DeleteOrUpdateOrAddCategory) async {
    if (await networkInfo.isConnected) {
      try {
        await DeleteOrUpdateOrAddCategory();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  
}