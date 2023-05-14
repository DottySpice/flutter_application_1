import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUseeWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserCredential.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (UserCredential.user!.emailVerified) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
