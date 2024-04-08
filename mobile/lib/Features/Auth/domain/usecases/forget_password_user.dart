import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Auth/domain/repositories/UserRepository.dart';


class ForgetPasswordUserUseCase {
  final UserRepository userRepository;

  ForgetPasswordUserUseCase(this.userRepository);
      Future<Either<Failure, Unit>> call(String email) async {
        print("use case");
        return await userRepository.forgetPassword(email);
      }
}