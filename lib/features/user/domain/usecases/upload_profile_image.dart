import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class UploadProfileImageUsecase {
  final UserRepository repository;
  UploadProfileImageUsecase(this.repository);

  Future<Either<Failure, String>> call(File image, String name) async {
    return await repository.uploadProfileImage(image, name);
  }
}
