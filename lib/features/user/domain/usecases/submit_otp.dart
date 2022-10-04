import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SubmitOTPUsecase {
  final AuthRepository repository;
  SubmitOTPUsecase(this.repository);

  Future<Either<Failure, User>> call(String otp) async {
    return await repository.submitOTP(otp);
  }
}
