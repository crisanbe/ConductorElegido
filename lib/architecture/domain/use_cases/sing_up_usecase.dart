import 'package:conductor_elegido/architecture/data/firebase/auth_firebase.dart';

class SignUpUseCase {
  final AuthenticationRepository authenticationRepository;

  SignUpUseCase(this.authenticationRepository);

  Future<void> execute(
      String typeDocument,
      String document,
      String fullName,
      String contacto,
      String email,
      String password,
      int status,
      DateTime dateBirth,
      String zoneCoverage,
      String eps,
      String address,
      String dateOfRegistration
      ) async {
    await authenticationRepository.signUpUser(
        typeDocument,
        document,
        fullName,
        contacto,
        email,
        password,
        status,
        dateBirth,
        zoneCoverage,
        eps,
        address,
        dateOfRegistration
    );
  }
}
