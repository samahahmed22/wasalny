import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart' as user;
import '../repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository repository;
  SignInUsecase(this.repository);

  Future<Either<Failure, user.User>> call(PhoneAuthCredential credential) async {
    return await repository.signIn(credential);
  }
}