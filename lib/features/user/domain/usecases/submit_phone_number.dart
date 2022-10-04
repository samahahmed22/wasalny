import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class SubmitPhoneNumberUsecase {
  final AuthRepository repository;
  SubmitPhoneNumberUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String number) async {
    return await repository.submitPhoneNumber(number);
  }
}
