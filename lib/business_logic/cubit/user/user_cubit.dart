import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


import '../../../shared/variables.dart';
import '../../../data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  UserModel? user;

  Future<void> loadUserData() async {
    emit(Loading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      if (value == null) {
        emit(UserDataNotLoaded());
      } else {
        user = UserModel.fromJson(value.data()!);

        emit(UserDataLoaded(user: user!));
      }
    }).catchError((error) {
      print(error.toString());
      emit(ErrorOccurred(errorMsg: error.toString()));
    });
  }

  Future<String> uploadImageAndGetUrl(File image, String name) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('users_images')
        .child(name + '.jpg');
    await ref.putFile(image);
    final url = await ref.getDownloadURL();

    return url;
  }

  Future<void> saveUserData(UserModel user, File? image) async {
    emit(Loading());
    if (image != null) {
      user.imageUrl = await uploadImageAndGetUrl(image, user.id);
    }
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
      user = user;
      emit(UserDataSaved());
    } catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
