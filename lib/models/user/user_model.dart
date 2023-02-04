import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName;
  final String location;
  final String age;
  final String email;
  final String passWord;
  final String avatar;

  UserModel({
    required this.fullName,
    required this.location,
    required this.age,
    required this.email,
    required this.passWord,
    required this.avatar,
  });

  factory UserModel.fromFirestore(DocumentSnapshot map) {
    return UserModel(
      location: map['location'],
      avatar: map['avatar'],
      email: map['email'],
      fullName: map['fullName'],
      passWord: map['passWord'],
      age: map['age'],
    );
  }
}
