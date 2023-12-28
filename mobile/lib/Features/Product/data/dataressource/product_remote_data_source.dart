import 'dart:convert';
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/Features/Product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProduct(int id);
  Future<Unit> updateProduct(ProductModel productModel);
  Future<Unit> addProduct(ProductModel productModel);
  Future<Unit> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProduct(int id) async {
      print(id);
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
        print(productModels);
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
    final request = {
      "name": productModel.name,
      "photo": productModel.photo,
      "description": productModel.description,
      "id_categorie": productModel.id_categorie,
    };

    final response = await client.post(
        Uri.parse(BASE_URL_BACKEND + "/product/AddProduct"),
        body: request);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(int id) async {
    final response = await client.delete(
      Uri.parse(BASE_URL_BACKEND +
          "/product/DeleteProduct/${id.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProduct(ProductModel productModel) async {
   
    final ProductId = productModel.id;
    final request = {
      "name": productModel.name,
      "photo": productModel.photo,
      "description": productModel.description,
      "id_categorie": productModel.id_categorie,
    };
    
    final response = await client.put(
      Uri.parse(BASE_URL_BACKEND + "/product/UpdateProduct/$ProductId"),
      body: request,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
