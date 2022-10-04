import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart' as user;

abstract class AuthRepository {
  Future<Either<Failure, Unit>> submitPhoneNumber(String number);
  Future<Either<Failure, user.User>> submitOTP(String otpCode);
  Future<Either<Failure, user.User>> signIn(PhoneAuthCredential credential);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, user.User>> getCurrentUser();
}
