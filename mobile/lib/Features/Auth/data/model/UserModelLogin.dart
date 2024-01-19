import 'package:mobile/Features/Auth/domain/entities/login_entity.dart';

class UserModelLogin extends LoginEntity {
  UserModelLogin(
      {
      String? id,
      required String email,
      password,
      int? role,
      String? nom,
      String? prenom,
      String? accessToken,
    })
      :  super(
          id: id,
          email: email,
          password: password,
          role: role,
          accessToken: accessToken,
          nom: nom,
          prenom: prenom,
          );
  factory UserModelLogin.fromJson(Map<String, dynamic> json) {
  return UserModelLogin(
    id: "1",
    email: json['email'], 
    password:json['password'], 
    nom: json['nom'], 
    prenom: json['prenom'], 
    role:json['isAdmin'] as int?,
    accessToken:json['token'], 
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'isAdmin': role,
      'token': accessToken,
      'nom': nom,
      'prenom': prenom,
    };
  }

  @override
   String toString() {
    return 'UserModelLogin{id: $id, email: $email, password: $password, role: $role, accessToken: $accessToken, nom: $nom, prenom: $prenom}';
  }
}