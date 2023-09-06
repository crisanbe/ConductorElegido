abstract class AuthenticationRepository {
  Future<void> signUpUser(
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
      String Address
      );

  Future<void> login(
      String email,
      String password
      );
}
