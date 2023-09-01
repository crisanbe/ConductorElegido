import 'package:conductor_elegido/architecture/data/firebase/auth_firebase.dart';

class SignUpUseCase {
  final UserRepository userRepository;
  SignUpUseCase(this.userRepository);

  Future<void> execute(String email, String password, String status) async {
    await userRepository.signUpUser(email, password,status);
  }
}
