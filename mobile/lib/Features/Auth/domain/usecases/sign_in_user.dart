import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Auth/domain/entities/login_entity.dart';
import 'package:mobile/Features/Auth/domain/repositories/UserRepository.dart';


class SignInUserUseCase {
  final UserRepository userRepository;

  SignInUserUseCase(this.userRepository);
      Future<Either<Failure, Unit>> call(LoginEntity user) async {
        return await userRepository.signIn(user);
      }
}