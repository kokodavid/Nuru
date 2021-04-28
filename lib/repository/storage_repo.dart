import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:nuru/models/user_model.dart';

import 'auth_repo.dart';
import '../helpers/locator.dart';


class StorageRepo {
  firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instanceFor(bucket: 'gs://nuru-7b6e6.appspot.com');
  AuthRepo _authRepo = locator.get<AuthRepo>();

  Future<String> uploadFile(File file) async {
    UserModel user = await _authRepo.getUser();
    var userId = user.uid;

    var storageRef = _storage.ref().child("user/profile/$userId");
    var uploadTask = storageRef.putFile(file);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    print("downloadLink | $imageUrl");
    return imageUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
}