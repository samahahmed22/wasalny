import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasalny/features/user/data/models/user_model.dart';

import '../error/exceptions.dart';

abstract class PhoneAuthConsumer {
  Future<dynamic> submitPhoneNumber(String number);
  Future<dynamic> submitOTP(String otpCode);
  Future<dynamic> signIn(PhoneAuthCredential credential);
  dynamic get currentUser;
  Stream<dynamic> authStateChanges();
  Future<dynamic> logout();
}

class PhoneAuthConsumerImpl implements PhoneAuthConsumer {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String verificationId;

  @override
  Future submitPhoneNumber(String number) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+966$number',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) async {
    if (error.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
    print('verificationFailed :${error.toString()}');
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  @override
  Future submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  @override
  Future signIn(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      debugPrint(error.code);
      throw const ServerException();
    }
  }

  @override
  Stream authStateChanges() {
    try {
      return _firebaseAuth.authStateChanges();
    } on FirebaseAuthException catch (error) {
      debugPrint(error.code);
      throw const ServerException();
    }
  }

  @override
  get currentUser => _firebaseAuth.currentUser;

  @override
  Future logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      print('Error.........' );
      print(error);
      debugPrint(error.code);
      throw const ServerException();
    }
  }
}
