import 'dart:convert';
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Categorie/data/models/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/injection_container.dart';

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

  final UserLocalDataSource userLocalDataSource = sl.get<UserLocalDataSource>();

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL_BACKEND/category/AllCategory"),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 5));
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
    final user = await userLocalDataSource.getCachedUser();

    var request = http.MultipartRequest(
        'POST', Uri.parse(BASE_URL_BACKEND + "/category/AddCategory"));
    request.fields['name'] = categoryModel.name;
    request.files.add(
        await http.MultipartFile.fromPath('photo', categoryModel.photo.path));
    request.headers['Authorization'] = 'Bearer ${user!.accessToken}';
    try {
      print(request.fields);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteCategory(int CategorieId) async {
    final user = await userLocalDataSource.getCachedUser();

    final response = await client.delete(
        Uri.parse(BASE_URL_BACKEND +
            "/category/DeleteCategory/${CategorieId.toString()}"),
        headers: {'Authorization': 'Bearer ${user!.accessToken}'});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateCategory(CategoryModel categoryModel) async {
    final user = await userLocalDataSource.getCachedUser();
    final CategorieId = categoryModel.id;
    var request = http.MultipartRequest(
        'POST', Uri.parse(BASE_URL_BACKEND + "/category/UpdateCategory/$CategorieId"));
    request.fields['name'] = categoryModel.name;
    print(categoryModel.photo.path);
    if(categoryModel.photo.path!='path'){
      request.files.add(
          await http.MultipartFile.fromPath('photo', categoryModel.photo.path));
    }
    request.headers['Authorization'] = 'Bearer ${user!.accessToken}';
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> AccepetCategory(int CategorieId) async {
    final user = await userLocalDataSource.getCachedUser();

    final response = await client.put(
        Uri.parse(BASE_URL_BACKEND +
            "/category/AcceptCategory/${CategorieId.toString()}"),
        headers: {'Authorization': 'Bearer ${user!.accessToken}'});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> RejectCategory(int CategorieId) async {
    final user = await userLocalDataSource.getCachedUser();

    final response = await client.put(
        Uri.parse(BASE_URL_BACKEND +
            "/category/RejectCategory/${CategorieId.toString()}"),
        headers: {'Authorization': 'Bearer ${user!.accessToken}'});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
