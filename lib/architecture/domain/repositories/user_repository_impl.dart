import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conductor_elegido/architecture/data/firebase/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> signUpUser(String email, String password, String status) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'status': status,
      });
    } catch (e) {
      // Handle errors
      throw e;
    }
  }


  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firebaseFirestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
      return null; // User data doesn't exist
    } catch (e) {
      // Handle errors
      return null;
    }
  }
}