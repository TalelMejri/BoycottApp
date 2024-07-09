import 'dart:convert';
import 'package:com.talel.boycott/Core/Strings/constantes.dart';
import 'package:com.talel.boycott/Core/failures/exception.dart';
import 'package:com.talel.boycott/Features/Categorie/data/models/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class CatyegoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategory();
  Future<Unit> updateCategory(CategoryModel CategoryModel);
  Future<Unit> addCategory(CategoryModel CategoryModel);
  Future<Unit> deleteCategory(int CategoryId);
  Future<List<CategoryModel>> getAllRequest(int status);
  Future<Unit> AccepetCategory(int CategoryId);
  Future<Unit> RejectCategory(int CategoryId);
}

class CategoryRemoteDataSourceImpl implements CatyegoryRemoteDataSource {
  final http.Client client;
  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL_BACKEND/category/AllCategory"),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 5));
      print(response.body);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['categories'] as List;
        final List<CategoryModel> categoryModels = data
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
        print(categoryModels);
        return categoryModels;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<List<CategoryModel>> getAllRequest(int status) async {
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL_BACKEND/category/AllRequest?status=${status}"),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['categories'] as List;
        final List<CategoryModel> categoryModels = data
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
        return categoryModels;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addCategory(CategoryModel categoryModel) async {
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteCategory(int CategorieId) async {
    return Future.value(unit);
  }

  @override
  Future<Unit> updateCategory(CategoryModel categoryModel) async {
    return Future.value(unit);
  }

  @override
  Future<Unit> AccepetCategory(int CategorieId) async {
    return Future.value(unit);
  }

  @override
  Future<Unit> RejectCategory(int CategorieId) async {
    return Future.value(unit);
  }
}
