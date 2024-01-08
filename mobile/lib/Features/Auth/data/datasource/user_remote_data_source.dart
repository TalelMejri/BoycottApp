import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/Features/Auth/domain/entities/login_entity.dart';


abstract class UserRemoteDataSource {
  Future<UserModelLogin> signInUser(LoginEntity userModel);
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

  
}