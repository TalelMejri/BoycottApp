import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/Features/Auth/domain/entities/Payload.dart';
import 'package:mobile/Features/Auth/domain/entities/login_entity.dart';

abstract class UserRemoteDataSource {
  Future<UserModelLogin> signInUser(LoginEntity userModel);
  Future<Unit> signUpUser(LoginEntity userModel);
  Future<Unit> verifyUser(String code,String email);
  Future<Unit> ForgetPassword(String email);
  Future<Unit> ResetPassword(payloadEntity data);
  Future<void> signOutUser();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {

  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModelLogin> signInUser(LoginEntity userModel) async {
    final body = jsonEncode(
          {"email": userModel.email, "password": userModel.password}
        );
    late final response;
    try {
      response = await client.post(Uri.parse(BASE_URL_BACKEND+"/auth/login"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: body);
    } catch (e) {
      print("exception " + e.toString());
    }
    response.body["photo"]="";
    if (response.statusCode == 200) {
      try {
        final user = UserModelLogin.fromJson(jsonDecode(response.body));
        return Future.value(user);
      } catch (e) {
        return Future.value(null);
      }
    } else {
      throw LoginException();
    }
  }

  @override
  Future<void> signOutUser() {
    throw UnimplementedError();
  }


  @override
  Future<Unit> signUpUser(LoginEntity userModel) async {
    final body = jsonEncode(
          {"email": userModel.email, 
           "password": userModel.password,
           "prenom":userModel.prenom,
           "nom":userModel.nom,
           }
        );
    late final response;
    try {
      response = await client.post(Uri.parse(BASE_URL_BACKEND+"/auth/register"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: body);
    } catch (e) {
      print("exception " + e.toString());
    }
    if (response.statusCode == 200) {
      try {
        return Future.value(unit);
      } catch (e) {
        return Future.value(null);
      }
    } else {
      throw RegisterException();
    }
  }

   @override
  Future<Unit> verifyUser(String code,String email) async {
    final body = jsonEncode(
          {"email":email,"token":code}
        );
    late final response;
    try {
      response = await client.post(Uri.parse(BASE_URL_BACKEND+"/auth/VerifyEmail"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: body);
    } catch (e) {
      print("exception " + e.toString());
    }
    if (response.statusCode == 200) {
      try {
        return Future.value(unit);
      } catch (e) {
        return Future.value(null);
      }
    } else {
      throw Exception(jsonDecode(response.body)['data'].toString());
    }
  }

  @override
  Future<Unit> ForgetPassword(String email) async {
    late final response;
    try {
      response = await client.post(Uri.parse(BASE_URL_BACKEND+"/auth/ForgotPassword/${email}"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body:'');
    } catch (e) {
      print("exception " + e.toString());
    }
    print(response.body);
    if (response.statusCode == 200) {
      try {
        return Future.value(unit);
      } catch (e) {
        return Future.value(null);
      }
    } else {
      throw Exception(jsonDecode(response.body)['data'].toString());
    }
  }

     @override
  Future<Unit> ResetPassword(payloadEntity data) async {
    final body = jsonEncode(
          {"email":data.email,"token":data.token,"password":data.password}
        );
    late final response;
    try {
      response = await client.post(Uri.parse(BASE_URL_BACKEND+"/auth/ChangerPassword"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: body);
    } catch (e) {
      print("exception " + e.toString());
    }
    if (response.statusCode == 200) {
      try {
        return Future.value(unit);
      } catch (e) {
        return Future.value(null);
      }
    } else {
      throw Exception(jsonDecode(response.body)['data'].toString());
    }
  }

}