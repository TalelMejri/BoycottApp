import 'package:equatable/equatable.dart';

class payloadEntity extends Equatable {
    final String email;
    final String token;
    final String password;

    const payloadEntity({
      required this.email,
      required this.password,
      required this.token,
    });

    @override
    List<Object?> get props => [email,password,token];

}