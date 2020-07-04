import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateImageProfile {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  updatePro(imgUrl, context) {
    var userInfo = UserUpdateInfo();
    userInfo.photoUrl = imgUrl;
    FirebaseAuth.instance.currentUser().then((user) {
      user.updateProfile(userInfo);
      Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
            Firestore.instance
                .document('users/${docs.documents[0].documentID}')
                .updateData({'imgprofile': imgUrl}).then((val) {
              print('ok');
            }).then((user) {
              print('ok wow');
            }).catchError((e) {
              print('can\'t change pages ' + e);
            });
          })
          .catchError((e) {
            print('users error '+ e);
          })
          .catchError((e) => print('update pic '+ e))
          .catchError((e) => print('first '+ e));
    });
  }

  // Update Visahagit Image Profile
  updateVisaPro(imgUrl, context) {
    var userInfo = UserUpdateInfo();
    userInfo.photoUrl = imgUrl;
    FirebaseAuth.instance.currentUser().then((user) {
      user.updateProfile(userInfo);
      Firestore.instance
          .collection('visa')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
            Firestore.instance
                .document('users/${docs.documents[0].documentID}')
                .updateData({'imgprofile': imgUrl}).then((val) {
              print('ok');
            }).then((user) {
              print('ok wow');
            }).catchError((e) {
              print('can\'t change pages ' + e);
            });
          })
          .catchError((e) {
            print('users error '+ e);
          })
          .catchError((e) => print('update pic '+ e))
          .catchError((e) => print('first '+ e));
    });
  }

  updateImageUserProfile(imgUrl, context) async {
    var userInfo = UserUpdateInfo();

    userInfo.photoUrl = imgUrl;
    auth.currentUser().then((user){
      user.updateProfile(userInfo);
      firestore.collection('users')
      .where('uid', isEqualTo: user.uid)
      .getDocuments()
      .then((docs){
        firestore.document('users/${docs.documents[0].documentID}')
        .updateData({
          'imgpro': imgUrl
        }).then((_){
          debugPrint('update image profile success');
        }).catchError((e){

          debugPrint('update image profile err: $e');
        });
      });
    });
  }


   updateImageVisaProfile(imgUrl, context) async {
    var userInfo = UserUpdateInfo();

    userInfo.photoUrl = imgUrl;
    auth.currentUser().then((user){
      user.updateProfile(userInfo);
      firestore.collection('visa')
      .where('uid', isEqualTo: user.uid)
      .getDocuments()
      .then((docs){
        firestore.document('visa/${docs.documents[0].documentID}')
        .updateData({
          'imgpro': imgUrl
        }).then((_){
          debugPrint('update image profile success');
        }).catchError((e){

          debugPrint('update image profile err: $e');
        });
      });
    });
  }












}