import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Auth/domain/entities/login_entity.dart';
import 'package:mobile/Features/Auth/domain/entities/signup_entity.dart';

abstract class UserRepository {

  Future<Either<Failure, Unit>> signIn(LoginEntity user);
  Future<Either<Failure, Unit>> signUp(SignUpEntity user);
  Future<Either<Failure, Unit>> signOut();
  Future<LoginEntity?> getCachedUser();
  
}