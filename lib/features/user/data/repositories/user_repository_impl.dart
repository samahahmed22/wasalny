import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wasalny/features/user/data/datasources/user_remote_data_source.dart';
import 'package:wasalny/features/user/data/models/user_model.dart';

import 'package:wasalny/features/user/domain/repositories/user_repository.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/exceptions.dart';

typedef Future<Unit> AddUser();

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final NetworkInfo _networkInfo;
  UserRepositoryImpl(this._networkInfo, this._userRemoteDataSource);

  Future<Either<Failure, User>> getUserData(String uId) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _userRemoteDataSource.getUserData(uId));
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException{
        return Left(NoDataFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> setUserData(User user) async {
    UserModel userModel = UserModel(
        id: user.id,
        phoneNumber: user.phoneNumber,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        imageUrl: user.imageUrl);

    return await _getMessage(() {
      return _userRemoteDataSource.setUserData(userModel);
    });
  }

  Future<Either<Failure, String>> uploadProfileImage(
      File image, String name) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(
            await _userRemoteDataSource.uploadImageAndGetUrl(image, name));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(AddUser addUser) async {
    if (await _networkInfo.isConnected) {
      try {
        await addUser();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
