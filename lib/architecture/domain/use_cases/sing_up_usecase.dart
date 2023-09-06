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
      String status,
      DateTime dateBirth,
      DateTime dateExpirationLicense,
      DateTime licensCurrentlyExpired,
      String ZoneCoverage,
      String Address) async {
    await authenticationRepository.signUpUser(
        typeDocument,
        document,
        fullName,
        contacto,
        email,
        password,
        status,
        dateBirth,
        dateExpirationLicense,
        licensCurrentlyExpired,
        ZoneCoverage,
        Address);
  }
}
