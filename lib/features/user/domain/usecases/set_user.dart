import 'package:dartz/dartz.dart';
import 'package:wasalny/core/error/failures.dart';
import 'package:wasalny/features/user/domain/repositories/user_repository.dart';

import '../entities/user.dart';

class SetUserUsecase {
  final UserRepository repository;
  SetUserUsecase(this.repository);

  Future<Either<Failure, Unit>> call(User user) async {
    return await repository.setUserData(user);
  }
}
