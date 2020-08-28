import 'dart:io';

class UserInfo {
  UserInfo._privateConstructor();

  static final UserInfo _instance = UserInfo._privateConstructor();

  factory UserInfo() {
    return _instance;
  }

  String firstName, lastName, serverImageUri, desc, email;
  File localImageUri;

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'localImageUri': this.localImageUri,
      'serverImageUri': this.serverImageUri,
      'desc': this.desc,
      'email': this.email
    };
  }
}
