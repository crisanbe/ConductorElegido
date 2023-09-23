
abstract class AuthenticationRepository {
  Future<void> signUpUser(
      String typeDocument,
      String document,
      String fullName,
      String contact,
      String email,
      String password,
      int status,
      DateTime dateBirth,
      String zoneCoverage,
      String eps,
      String address,
      String createat
      );

  Future<void> login(
      String email,
      String password
      );
}
