
import 'package:mobile/Core/network/network_info.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:mobile/Features/Categorie/data/dataressource/category_local_data_source.dart';
import 'package:mobile/Features/Categorie/data/dataressource/category_remote_data_source.dart';
import 'package:mobile/Features/Categorie/data/repositories/category_repository.dart';
import 'package:mobile/Features/Categorie/domain/repositories/CategoryRepository.dart';
import 'package:mobile/Features/Categorie/domain/usecases/UpdateCategory.dart';
import 'package:mobile/Features/Categorie/domain/usecases/addCategory.dart';
import 'package:mobile/Features/Categorie/domain/usecases/deleteCategory.dart';
import 'package:mobile/Features/Categorie/domain/usecases/get_all.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:mobile/Features/Product/data/dataressource/product_remote_data_source.dart';
import 'package:mobile/Features/Product/data/dataressource/product_local_data_source.dart';
import 'package:mobile/Features/Product/data/repositories/Product_repository.dart';
import 'package:mobile/Features/Product/domain/repositories/ProductRepository.dart';
import 'package:mobile/Features/Product/domain/usecases/UpdateProduct.dart';
import 'package:mobile/Features/Product/domain/usecases/addProduct.dart';
import 'package:mobile/Features/Product/domain/usecases/deleteProduct.dart';
import 'package:mobile/Features/Product/domain/usecases/get_all.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async 
{

  //bloc
  sl.registerFactory(() => CategoryBloc(getAllCategory: sl()));
  sl.registerFactory(() => AdddeleteupdateCategoryBloc(
      addCategory: sl(), updateCategory: sl(), deleteCategory: sl()));
  
  sl.registerFactory(() => ProductBloc(getAllProduct: sl()));
  sl.registerFactory(() => AdddeleteupdateProductBloc(
      addProduct: sl(), updateProduct: sl(), deleteProduct: sl()));

  
  //usecases
  sl.registerLazySingleton(() => GetAllCategoryUsecase(sl()));
  sl.registerLazySingleton(() => AddCategoryUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUsecase(sl()));

  sl.registerLazySingleton(() => GetAllProductUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));


  //repository
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  

  //Datasources
  sl.registerLazySingleton<CatyegoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  
  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

    
}