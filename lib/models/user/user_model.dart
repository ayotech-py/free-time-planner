import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? fullName;
  final String? location;
  final String? age;
  final String? bio;
  final String? email;
  final String? passWord;
  final String? avatar;
  final String? budget;
  final String? availableFrom;
  final String? availableTo;

  UserModel({
    this.fullName,
    this.location,
    this.age,
    this.email,
    this.passWord,
    this.avatar,
    this.bio,
    this.budget,
    this.availableFrom,
    this.availableTo,
  });

  factory UserModel.fromFirestore(DocumentSnapshot map) {
    return UserModel(
      bio: map['bio'] ?? '',
      location: map['location'],
      avatar: map['avatar'],
      email: map['email'],
      fullName: map['fullName'],
      passWord: map['passWord'],
      age: map['age'],
      budget: map['budget'] ?? '',
      availableFrom: map['availableFrom'] ?? "",
      availableTo: map['availableTo'] ?? '',
    );
  }
}
