import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wasalny/core/firebase/api_path.dart';
import 'package:wasalny/core/firebase/firebase_firestore_consumer.dart';
import 'package:wasalny/core/firebase/firebase_storage_consumer.dart';
import 'package:wasalny/features/user/data/models/user_model.dart';
import 'package:path/path.dart' as p;

import '../../../../core/error/exceptions.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserData(String id);
  Future<Unit> setUserData(UserModel user);
  Future<String> uploadImageAndGetUrl(File image, String name);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirestoreConsumer fireStore;
  final StorageConsumer storage;

  UserRemoteDataSourceImpl({required this.fireStore, required this.storage});
  @override
  Future<UserModel> getUserData(String id) async {
    final response = await fireStore.getData(path: ApiPath.user(id));
    if (response == null) {
      throw NoDataException();
    } else {
      return UserModel.fromJson(response);
    }
  }

  @override
  Future<Unit> setUserData(UserModel user) async {
    final response = await fireStore.setData(
        path: ApiPath.user(user.id), data: user.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> uploadImageAndGetUrl(File image, String name) async {
    final response = await storage.saveFileAndGetUrl(
        path: ApiPath.profileImage(name + p.extension(image.path)),
        file: image);

    return response;
  }
}
