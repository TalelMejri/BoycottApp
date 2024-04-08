import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Core/failures/exception.dart';
import 'package:com.talel.boycott/Features/Product/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProduct();
  Future<Unit> cacheProduct(List<ProductModel> ProductModel);
}

const CACHED_KEY = "CACHED_Product";

class ProductLocalDataSourceImpl implements ProductLocalDataSource {


  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheProduct(List<ProductModel> ProductModels) {
    List ProductModelsToJson = ProductModels
        .map<Map<String, dynamic>>((ProductModel) => ProductModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_KEY, json.encode(ProductModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getCachedProduct() {
    final jsonString = sharedPreferences.getString(CACHED_KEY);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<ProductModel> jsonToProductModels = decodeJsonData
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
      return Future.value(jsonToProductModels);
    } else {
      throw EmptyCacheException();
    } 
  }
  
}