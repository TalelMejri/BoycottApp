import 'package:com.talel.boycott/Features/Auth/domain/entities/login_entity.dart';
import 'package:com.talel.boycott/Features/Auth/domain/repositories/UserRepository.dart';


class GetCachedUserUseCase {

  final UserRepository userRepository;

  GetCachedUserUseCase(this.userRepository);
    Future<LoginEntity?> call() async {
          return await userRepository.getCachedUser();
    }

}