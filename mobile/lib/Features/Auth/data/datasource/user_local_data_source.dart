import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Core/failures/exception.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<UserModelLogin?> getCachedUser();
  Future<Unit> cacheUser(UserModelLogin user);
  Future<Unit> clearCachedUser();
}

class UserLocalDataSourceImpl extends UserLocalDataSource {
  
  final SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<Unit> cacheUser(UserModelLogin user) {
    sharedPreferences.setString(CACHED_USER, json.encode(user.toJson()));
    return Future.value(unit);
  }

  @override
  Future<UserModelLogin?> getCachedUser() {
    final userJsonString = sharedPreferences.getString(CACHED_USER);
    if (userJsonString != null) {
      UserModelLogin user = UserModelLogin.fromJson(json.decode(userJsonString));
      return Future.value(user);
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<Unit> clearCachedUser() {
    sharedPreferences.remove(CACHED_USER);
    return Future.value(unit);
  }


}