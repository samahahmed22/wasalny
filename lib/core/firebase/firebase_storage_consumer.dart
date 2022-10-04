import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';

abstract class StorageConsumer {
  Future<dynamic> saveFileAndGetUrl({required String path, required File file});
}

class StorageConsumerImpl implements StorageConsumer {
  final _storage = FirebaseStorage.instance;
  @override
  Future saveFileAndGetUrl(
      {required String path, required File file}) async {
    try {
      final reference = _storage.ref().child(path);
      await reference.putFile(file);
      debugPrint('Request Data: $file');
      return await reference.getDownloadURL();
    } on FirebaseException catch (error) {
      debugPrint(error.code);
      throw const ServerException();
    }
  }
}
