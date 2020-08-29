import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_flutter/singleton/user_info.dart';
import 'package:go_flutter/singleton/user_info.dart';

class FirebaseUtils {
  StorageReference rootRef = FirebaseStorage.instance.ref().child('images');

  CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> registerToAuth(String email, password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    if (userCredential != null) {
      return true;
    } else {
      return null;
    }
  }

  Future<String> logUser(String email, password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential != null) {
      return userCredential.user.uid;
    } else {
      return null;
    }
  }

  Future<dynamic> uploadImage(File imageFile) async {
    String imageId = UniqueKey().toString();
    print(imageFile.path);
    final StorageUploadTask task = rootRef.child(imageId).putFile(imageFile);
    StorageTaskSnapshot snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL();
  }

  Future<bool> uploadUserInfo(UserDetails userInfo) async {
    print("Uploading user info");
    DocumentReference documentReference = await usersRef.add(userInfo.toJson());
    if (documentReference != null) {
      return true;
    } else {
      return false;
    }
  }

  User getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<UserDetails> getUserInfo() async {
    User user = getCurrentUser();
    String uid = user.uid;
    UserDetails userDetails = UserDetails();
    QuerySnapshot querySnapshot =
        await usersRef.where('uid', isEqualTo: uid).get();
    if (querySnapshot.docs.length > 0) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        userDetails = UserDetails.toObject(documentSnapshot.data());
      }
      return userDetails;
    } else {
      return null;
    }
  }

  Future signOut() {
    return firebaseAuth.signOut();
  }
}
