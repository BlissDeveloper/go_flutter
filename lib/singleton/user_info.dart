import 'dart:io';

class UserDetails {
  UserDetails._privateConstructor();

  static final UserDetails _instance = UserDetails._privateConstructor();

  factory UserDetails() {
    return _instance;
  }

  String firstName, lastName, serverImageUri, desc, email, uid;
  File localImageFile;

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'serverImageUri': this.serverImageUri,
      'desc': this.desc,
      'email': this.email,
      'uid': this.uid
    };
  }
}
