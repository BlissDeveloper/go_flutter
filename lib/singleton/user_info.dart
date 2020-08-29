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

  static UserDetails toObject(Map<String, dynamic> map) {
    UserDetails userDetails = new UserDetails();
    userDetails.firstName = map['firstName'];
    userDetails.lastName = map['lastName'];
    userDetails.serverImageUri = map['serverImageUri'];
    userDetails.desc = map['desc'];
    userDetails.email = map['email'];
    userDetails.uid = map['uid'];

    return userDetails;
  }
}
