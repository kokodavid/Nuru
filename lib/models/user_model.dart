import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String avatarUrl;

  const UserModel({required this.uid,required this.username,required this.email,required this.avatarUrl});

  static const empty = UserModel(email: '', uid: '', username: "", avatarUrl: "");

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["username"] = user.username;
    data["email"] = user.email;
    data["avatar"] = user.avatarUrl;

    return data;
  }

  @override
  List<Object> get props => [
    uid,
    username,
    email,
    avatarUrl,
  ];



}