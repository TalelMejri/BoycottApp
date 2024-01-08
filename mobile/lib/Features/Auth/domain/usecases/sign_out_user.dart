import 'package:dartz/dartz.dart';
import 'package:mobile/Core/failures/failures.dart';
import 'package:mobile/Features/Auth/domain/repositories/UserRepository.dart';


class SignOutUserUseCase {

  final UserRepository userRepository;

  SignOutUserUseCase(this.userRepository);
    Future<Either<Failure, Unit>> call() async {
        return await userRepository.signOut();
    }
    
}