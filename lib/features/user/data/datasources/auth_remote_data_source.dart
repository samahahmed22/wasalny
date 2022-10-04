import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wasalny/core/firebase/phone_auth.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart' as user;

abstract class AuthRemoteDataSource {
  Future<Unit> submitPhoneNumber(String number);
  Future<user.User> submitOTP(String otpCode);
  Future<user.User> signIn(PhoneAuthCredential credential);
  Future<user.User> get currentUser;
  // Stream<User> authStateChanges();
  Future<Unit> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final PhoneAuthConsumer phoneAuth;

  AuthRemoteDataSourceImpl({required this.phoneAuth});
  @override
  Future<Unit> submitPhoneNumber(String number) async {
    final response = await phoneAuth.submitPhoneNumber(number);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<user.User> submitOTP(String otpCode) async {
    final response = await phoneAuth.submitOTP(otpCode);
    return user.User(id: response.uid, phoneNumber: response.phoneNumber);
  }

  @override
  Future<user.User> get currentUser async {
    final response = await phoneAuth.currentUser;

    if (response == null) {
      throw NoDataException();
    } else {
      return user.User(id: response.uid, phoneNumber: response.phoneNumber);
    }
  }

  @override
  Future<user.User> signIn(PhoneAuthCredential credential) async {
    final response = await phoneAuth.signIn(credential);

    return user.User(id: response.uid, phoneNumber: response.phoneNumber);
  }

  // @override
  // Stream<User> authStateChanges() {
  //   final response =  phoneAuth.authStateChanges();

  //   return response.listen((user) { User(id: user.uid, phoneNumber: user.phoneNumber);});
  //   // return User(id: response.uid, phoneNumber: response.phoneNumber);
  // }

  @override
  Future<Unit> logout() async {
    final response = await phoneAuth.logout();

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
