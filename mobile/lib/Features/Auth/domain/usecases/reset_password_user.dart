import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Auth/domain/entities/Payload.dart';
import 'package:mobile/Features/Auth/domain/repositories/UserRepository.dart';


class ResetPasswordUserUseCase {
  final UserRepository userRepository;

  ResetPasswordUserUseCase(this.userRepository);
      Future<Either<Failure, Unit>> call(payloadEntity data) async {
        print("use case");
        return await userRepository.resetPassword(data);
      }
}