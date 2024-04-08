import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Auth/domain/entities/Payload.dart';
import 'package:com.talel.boycott/Features/Auth/domain/entities/login_entity.dart';

abstract class UserRepository {

  Future<Either<Failure, Unit>> signIn(LoginEntity user);
  Future<Either<Failure, Unit>> signUp(LoginEntity user);
  Future<Either<Failure, Unit>> signOut();
  Future<LoginEntity?> getCachedUser();
  Future<Either<Failure, Unit>> VerifyEmail(String code, String email);
  Future<Either<Failure, Unit>> forgetPassword(String email);
  Future<Either<Failure, Unit>> resetPassword(payloadEntity data);
}