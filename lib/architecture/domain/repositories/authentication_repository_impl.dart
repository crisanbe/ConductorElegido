import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conductor_elegido/architecture/data/firebase/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
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
      ) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore.collection('driver').doc(userCredential.user!.uid).set({
        'typeDocument': typeDocument,
        'document': document,
        'fullName': fullName,
        'contact': contact,
        'email': email,
        'password': password,
        'status': status,
        'dateBirth': dateBirth,
        'zoneCoverage': zoneCoverage,
        'eps': eps,
        'address': address,
        'createat': createat,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firebaseFirestore.collection('driver').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
      return null; // Los datos del usuario no existen
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}