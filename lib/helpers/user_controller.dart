import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuru/models/user_model.dart';
import 'package:nuru/models/user_profile.dart';

import 'auth_repo.dart';
import 'locator.dart';

class UserController{
  UserModel? _currentUser;
  AuthRepo _authRepo = locator.get<AuthRepo>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserProfile userProfile = UserProfile(lastName: '', firstName: '', phone: '', email: '');
  final userProfileRef = FirebaseFirestore.instance.collection("userProfile");

  late Future init;
  UserController() {
    init = initUser();
  }
  Future<UserModel?> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel? get currentUser => _currentUser;



  Future<dynamic> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      _currentUser = await _authRepo.signInWithEmailAndPassword(email, password);

      return "Logged In Successfully";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not registered. Sign Up to create a new account.";
      } else if (e.code == 'wrong-password') {
        return "Wrong email or password entered!";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  Future<UserProfile?> uploadProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    userProfile = UserProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,

    );
    final userMapData = userProfile.toJson();
    await userProfileRef.doc(_currentUser!.uid).set(userMapData).catchError((e) {
      print(e);
    });
  }

  //2
  // ignore: missing_return
  Future<String?> signUp({required String email, required String password, }) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return "Registered Successfully";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return "Successful";
    }catch(e){
      print(e);
    }
  }


}