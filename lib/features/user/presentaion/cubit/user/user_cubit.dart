import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wasalny/core/utils/app_strings.dart';
import 'package:wasalny/features/user/domain/usecases/get_user.dart';
import 'package:wasalny/features/user/domain/usecases/set_user.dart';
import 'package:wasalny/features/user/domain/usecases/upload_profile_image.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/entities/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SetUserUsecase setUser;
  final GetUserUsecase getUser;
  final UploadProfileImageUsecase uploadProfileImage;

  UserCubit(
      {required this.setUser,
      required this.getUser,
      required this.uploadProfileImage})
      : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  User? currentUser;

  Future<void> loadUserData() async {
    emit(Loading());

    Either<Failure, User> response = await getUser(currentUser!.id);

    response.fold(
        (failure) => emit(ErrorOccurred(errorMsg: _userFailureToMsg(failure))),
        (user) {
      currentUser = user;
      print(currentUser);
      emit(UserDataLoaded(user: user));
      // }
    });
  }

  Future<void> uploadImage(File image) async {
    Either<Failure, String> response =
        await uploadProfileImage(image, currentUser!.id);
    response.fold(
        (failure) => emit(ErrorOccurred(errorMsg: _userFailureToMsg(failure))),
        (url) => emit(ImageUploaded(url)));
  }

  Future<void> saveUserData(User user) async {
    emit(Loading());
    Either<Failure, Unit> response = await setUser(user);

    response.fold(
        (failure) => emit(ErrorOccurred(errorMsg: _userFailureToMsg(failure))),
        (_) => emit(UserDataSaved()));
  }

  String _userFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      case OfflineFailure:
        return AppStrings.offlineFailure;
      case NoDataFailure:
        return AppStrings.noDataFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
