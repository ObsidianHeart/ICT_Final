import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String name;
  String email;
  String uid;
  String phoneNo;

  UserDataModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.phoneNo,
  });

  factory UserDataModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> map) {
    return UserDataModel(
      name: map['name'],
      email: map['email'],
      uid: map['uid'],
      phoneNo: map['phoneNo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phoneNo': phoneNo,
    };
  }
}
