import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository{
  Future<Either<Failure, User>> getUserData(String uId);
  Future<Either<Failure, Unit>> setUserData(User user);
  Future<Either<Failure, String>> uploadProfileImage(File image, String name);
}