import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:mobile/Features/Categorie/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategory();
  Future<Unit> cachecategory(List<CategoryModel> categoryModel);
}

const CACHED_KEY = "CACHED_CATEGORY";

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {


  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachecategory(List<CategoryModel> CategoryModels) {
    List CategoryModelsToJson = CategoryModels
        .map<Map<String, dynamic>>((CategoryModel) => CategoryModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_KEY, json.encode(CategoryModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CategoryModel>> getCachedCategory() {
    final jsonString = sharedPreferences.getString(CACHED_KEY);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CategoryModel> jsonToCategoryModels = decodeJsonData
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
      return Future.value(jsonToCategoryModels);
    } else {
      throw EmptyCacheException();
    } 
  }
  
}