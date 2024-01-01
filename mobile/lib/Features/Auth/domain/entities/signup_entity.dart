import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
    final int? id;
    final String nom;
    final String prenom;
    final String email;
    final String password;
    final String photo;

    const SignUpEntity({
      this.id,
      required this.nom,
      required this.prenom,
      required this.email,
      required this.password,
      required this.photo,
    });

    @override
    List<Object?> get props => [id,nom,prenom,email,password,photo];

}