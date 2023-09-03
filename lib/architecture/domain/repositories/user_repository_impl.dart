import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conductor_elegido/architecture/data/firebase/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
      ) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'typeDocument': typeDocument,
        'document': document,
        'fullName': fullName,
        'contacto': contacto,
        'email': email,
        'password': password,
        'status': status,
        'dateBirth': dateBirth,
        'dateExpirationLicense': dateExpirationLicense,
        'licensCurrentlyExpired': licensCurrentlyExpired,
        'ZoneCoverage': ZoneCoverage,
        'Address': Address
      });
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firebaseFirestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
      return null; // Los datos del usuario no existen
    } catch (e) {
      return null;
    }
  }
}