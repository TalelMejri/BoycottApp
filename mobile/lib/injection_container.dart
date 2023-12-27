
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
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async 
{

  //bloc
  sl.registerFactory(() => CategoryBloc(getAllCategory: sl()));
  sl.registerFactory(() => AdddeleteupdateCategoryBloc(
      addCategory: sl(), updateCategory: sl(), deleteCategory: sl()));
  
  //usecases
  sl.registerLazySingleton(() => GetAllCategoryUsecase(sl()));
  sl.registerLazySingleton(() => AddCategoryUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUsecase(sl()));


  //repository
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  

  //Datasources
  sl.registerLazySingleton<CatyegoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(sharedPreferences: sl()));

  
  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

    
}