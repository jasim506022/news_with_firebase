import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? createdAt;

  ProfileModel({this.uid, this.name, this.email, this.createdAt});

  Map<String, dynamic> toMap() {
    return {"uid": uid, "name": name, "email": email, "createdAt": createdAt};
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map["uid"] != null ? map["uid"] as String : null,
      name: map["name"] != null ? map["name"] as String : null,
      email: map['email'] != null ? map["email"] as String : null,
      createdAt:
          map["createdAt"] != null ? map["createdAt"] as Timestamp : null,
    );
  }
}
