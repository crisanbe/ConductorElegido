import 'package:conductor_elegido/architecture/data/firebase/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  final AuthenticationRepository authenticationRepository;

  LoginUseCase(this.authenticationRepository);

  Future<void> login(String email, String password) async {
    try {
      await authenticationRepository.login(email, password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
