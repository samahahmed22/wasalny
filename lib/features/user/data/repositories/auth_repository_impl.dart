import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wasalny/features/user/data/datasources/auth_remote_data_source.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart' as user;
import '../../domain/repositories/auth_repository.dart';

typedef Future<Unit> SubmitPhoneNumberOrLogout();

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;
  AuthRepositoryImpl(this._authRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Unit>> submitPhoneNumber(String number) async {
    return await _getMessage(() {
      return _authRemoteDataSource.submitPhoneNumber(number);
    });
  }

  @override
  Future<Either<Failure, user.User>> submitOTP(String otpCode) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _authRemoteDataSource.submitOTP(otpCode));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, user.User>> signIn(
      PhoneAuthCredential credential) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _authRemoteDataSource.signIn(credential));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    return await _getMessage(() {
      return _authRemoteDataSource.logout();
    });
  }

  @override
  Future<Either<Failure, user.User>> getCurrentUser() async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _authRemoteDataSource.currentUser);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      SubmitPhoneNumberOrLogout submitPhoneNumberOrLogout) async {
    if (await _networkInfo.isConnected) {
      try {
        await submitPhoneNumberOrLogout();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
