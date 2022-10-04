import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';

abstract class FirestoreConsumer {
  Future<dynamic> setData({
    required String path,
    required Map<String, dynamic> data,
  });
  Future<dynamic> getData({
    required String path,
  });
  Future<dynamic> deleteData({required String path});
}

class FirestoreConsumerImpl implements FirestoreConsumer {
  final _fireStore = FirebaseFirestore.instance;
  @override
  Future setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final reference = _fireStore.doc(path);
      debugPrint('Request Data: $data');
      return await reference.set(data);
    } on FirebaseException catch (error) {
      debugPrint(error.code);
      throw const ServerException();
    }
  }

  @override
  Future getData({
    required String path,
  }) async {
    try {
      final reference = _fireStore.doc(path);
      final response = await reference.get();
      return (response.data());
    } on FirebaseException catch (error) {
      debugPrint(error.code);
      throw const ServerException();
    }
  }

  @override
  Future deleteData({required String path}) async {
    try {
      final reference = _fireStore.doc(path);
      debugPrint('Path: $path');
      await reference.delete();
    } on FirebaseException catch (error) {
      debugPrint(error.code);
      throw const ServerException();
    }
  }
}
