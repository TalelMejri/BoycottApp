import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final int? id;
  final String email;
  final String? password;
  final int? role;
  final String? accessToken;
  final String? nom;
  final String? prenom;
  LoginEntity(
      {this.id,
        required this.email,
       this.password,
       this.role,
       this.nom,
       this.prenom,
       this.accessToken});
  @override
  List<Object?> get props => [id, email,password,role,accessToken,nom,prenom];
}