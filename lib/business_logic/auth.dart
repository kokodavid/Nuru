// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuru/models/user.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Get User Id from Firebase
  OurUser? _userFromFirebaseUser(User user){
    return user != null ? OurUser(userId: user.uid) : null;
  }

  //Sign In with Email and Password Function
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
    }
  }

  //Sign Up with Email and Password Function

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch (e){
      print(e.toString());
    }
  }

  //Reset Password Function
  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  //Sign Out Function
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}