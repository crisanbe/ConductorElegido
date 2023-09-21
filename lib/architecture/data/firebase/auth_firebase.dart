
abstract class AuthenticationRepository {
  Future<void> signUpUser(
      String typeDocument,
      String document,
      String fullName,
      String contacto,
      String email,
      String password,
      int status,
      DateTime dateBirth,
      String ZoneCoverage,
      String Address,
      String DateOfRegistration
      );

  Future<void> login(
      String email,
      String password
      );
}
