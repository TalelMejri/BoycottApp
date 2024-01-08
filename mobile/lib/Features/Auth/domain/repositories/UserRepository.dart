import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Auth/domain/entities/login_entity.dart';

abstract class UserRepository {

  Future<Either<Failure, Unit>> signIn(LoginEntity user);
  Future<Either<Failure, Unit>> signUp(LoginEntity user);
  Future<Either<Failure, Unit>> signOut();
  Future<LoginEntity?> getCachedUser();
  Future<Either<Failure, Unit>> VerifyEmail(String code, String email);
  
}