import 'package:dartz/dartz.dart';
import 'package:wasalny/core/error/failures.dart';
import 'package:wasalny/features/user/domain/repositories/user_repository.dart';

import '../entities/user.dart';

class GetUserUsecase {
  final UserRepository repository;
  GetUserUsecase(this.repository);

  Future<Either<Failure, User>> call(String uId) async {
    return await repository.getUserData(uId);
  }
}
