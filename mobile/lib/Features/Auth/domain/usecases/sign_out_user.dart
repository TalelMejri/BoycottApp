import 'package:dartz/dartz.dart';
import 'package:com.talel.boycott/Core/failures/failures.dart';
import 'package:com.talel.boycott/Features/Auth/domain/repositories/UserRepository.dart';


class SignOutUserUseCase {

  final UserRepository userRepository;

  SignOutUserUseCase(this.userRepository);
    Future<Either<Failure, Unit>> call() async {
        return await userRepository.signOut();
    }
    
}