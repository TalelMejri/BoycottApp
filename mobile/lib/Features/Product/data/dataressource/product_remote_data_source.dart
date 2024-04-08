import 'dart:convert';
import 'package:com.talel.boycott/Core/Strings/constantes.dart';
import 'package:com.talel.boycott/Core/failures/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:com.talel.boycott/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:com.talel.boycott/Features/Product/data/models/product_model.dart';
import 'package:com.talel.boycott/injection_container.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProduct(int id);
  Future<Unit> updateProduct(ProductModel productModel);
  Future<Unit> addProduct(ProductModel productModel);
  Future<Unit> deleteProduct(int id);
  Future<List<ProductModel>> getAllRequestProduct(int id);
  Future<Unit> AccepetProduct(int ProductId);
  Future<Unit> RejectProduct(int ProductId);
  Future<ProductModel> CheckExisteProductTest(String code_fabricant);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  final UserLocalDataSource userLocalDataSource = sl.get<UserLocalDataSource>();

  @override
  Future<List<ProductModel>> getAllProduct(int id) async {
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL_BACKEND/product/GetProducts/$id"),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['products'] as List;
        final List<ProductModel> productModels = data
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
        return productModels;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllRequestProduct(int id) async {
    final user = await userLocalDataSource.getCachedUser();
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL_BACKEND/product/ListProduct/$id"),
        headers: {'Authorization': 'Bearer ${user!.accessToken}'},
      );
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['products'] as List;
        final List<ProductModel> productModels = data
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();

        return productModels;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addProduct(ProductModel productModel) async {
    final user = await userLocalDataSource.getCachedUser();
    var request = http.MultipartRequest(
        'POST', Uri.parse(BASE_URL_BACKEND + "/product/AddProduct"));
    request.fields['name'] = productModel.name;
    request.fields['description'] = productModel.description;
    request.fields['id_categorie'] = productModel.id_categorie.toString();
    request.fields['code_fabricant'] = productModel.code_fabricant.toString();
    request.files.add(
        await http.MultipartFile.fromPath('photo', productModel.photo.path));
    request.headers['Authorization'] = 'Bearer ${user!.accessToken}';
    try {
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
  Future<Unit> deleteProduct(int id) async {
    final user = await userLocalDataSource.getCachedUser();
    final response = await client.delete(
        Uri.parse(BASE_URL_BACKEND + "/product/DeleteProduct/$id"),
        headers: {'Authorization': 'Bearer ${user!.accessToken}'});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProduct(ProductModel productModel) async {
    final user = await userLocalDataSource.getCachedUser();
    final ProductId = productModel.id;
    var request = http.MultipartRequest('POST',
        Uri.parse(BASE_URL_BACKEND + "/product/UpdateProduct/$ProductId"));
    request.fields['name'] = productModel.name;
    request.fields['description'] = productModel.description;
    request.fields['id_categorie'] = productModel.id_categorie.toString();
    request.fields['code_fabricant'] = productModel.code_fabricant.toString();
    if (productModel.photo.path != 'path') {
      request.files.add(
          await http.MultipartFile.fromPath('photo', productModel.photo.path));
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
  Future<Unit> AccepetProduct(int id) async {
    final user = await userLocalDataSource.getCachedUser();
    final response = await client.put(
        Uri.parse(BASE_URL_BACKEND + "/product/AcceptProduct/$id"),
        headers: {'Authorization': 'Bearer ${user!.accessToken}'});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> RejectProduct(int id) async {
    final user = await userLocalDataSource.getCachedUser();
    final response = await client.put(
        Uri.parse(BASE_URL_BACKEND + "/product/RejectProduct/$id"),
        headers: {'Authorization': 'Bearer ${user!.accessToken}'});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
 Future<ProductModel> CheckExisteProductTest(String code_fabricant) async {
    try {
      final response = await client.get(
        Uri.parse(
            "$BASE_URL_BACKEND/product/IsCodeFabricantExist/$code_fabricant"),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        final ProductModel productModel = ProductModel.fromJson(data);
       
        return Future.value(productModel);
      } else {
        throw Exception(json.decode(response.body)['data']);
      }
    } on ServerException {
      throw ServerException();
    }
  }
}
