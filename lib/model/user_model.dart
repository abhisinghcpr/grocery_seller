import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uId;
  final String username;
  final String email;
  final String phone;
  final String userImg;
  final String userAddress;

  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userImg,
    required this.userAddress,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      userImg: map['userImg'],
      userAddress: map['userAddress'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'userImg': userImg,
      'userAddress': userAddress,
    };
  }
}
