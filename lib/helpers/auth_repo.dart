import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuru/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


class AuthRepo{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthRepo();

  Future<UserModel> getUser() async {
    var firebaseUser = await _auth.currentUser;
    return UserModel(uid: firebaseUser.uid, username: '', avatarUrl: '', email: '');
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
    });
  }

  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    var authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return UserModel(uid: authResult.user.uid, username: authResult.user.displayName, avatarUrl: '', email: '');
  }

}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(uid: uid, email: email, username: displayName, avatarUrl: photoURL);
  }
}