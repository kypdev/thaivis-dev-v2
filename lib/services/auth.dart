import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  checkLogin(context) async {
    auth.currentUser().then((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        print('has login');
        firestore
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          if (docs.documents[0].exists)
            Navigator.pushReplacementNamed(context, '/home/user');
        }).catchError((e) {
          firestore
              .collection('visa')
              .where('uid', isEqualTo: user.uid)
              .getDocuments()
              .then((docs) {
            if (docs.documents[0].exists)
              Navigator.pushReplacementNamed(context, '/home/visa');
          });
        });
      }
    });
  }

  // Navigation register screen
  userRegister(context, loginType) {
    if (loginType == 2) {
      Navigator.pushNamed(context, '/register/user');
    } else {
      Navigator.pushNamed(context, '/register/visa');
    }
  }

  // Process register user
  userSignup(context, fname, lname, email, pass) {
    auth.createUserWithEmailAndPassword(email: email, password: pass).then(
        (currentUser) => firestore
                .collection('users')
                .document(currentUser.user.uid)
                .setData({
              'firstname': fname,
              'lastname': lname,
              'email': email,
              'uid': currentUser.user.uid,
              'type': 'user'
            }).then((_) {
              print('signup: success ${currentUser.user.uid} ok');
              // Navigator.pushReplacementNamed(context, '/home/user');
            }).catchError((e) {
              print('signupErr: $e');
            }));
  }

  visaSignup(
    context,
    visaName,
    addrNo,
    road,
    subDistrict,
    district,
    province,
    zipCode,
    tel,
    location,
    email,
    pass,
    conpass,
  ) {
    // print('$visaName, $addrNo, $addrNo, $road, $subDistrict, $district, $province, $zipCode, $tel, $location, $email, $pass, $conpass');

    if (pass != conpass) {
      print('password not match');
    } else {
      print('visa regis');
      auth.createUserWithEmailAndPassword(email: email, password: pass).then(
          (currentUser) => firestore
                  .collection('visa')
                  .document(currentUser.user.uid)
                  .setData({
                'visaName': visaName,
                'addrNo': addrNo,
                'road': road,
                'subDistrict': subDistrict,
                'district': district,
                'province': province,
                'zipCode': zipCode,
                'tel': tel,
                'location': location,
                'email': email,
                'uid': currentUser.user.uid,
                'type': 'visa'
              }).then((_) {
                print('signup success ${currentUser.user.uid}');
                Navigator.pushReplacementNamed(context, '/home/visa');
              }).catchError((e) => print('err: $e')));
    }
  }

  signWighEmail(context, email, pass, loginType) async {
    // print('login: $email, $pass, $loginType');

    if (loginType == 1) {
      print('loginType: $loginType Visa');
      // auth.signInWithEmailAndPassword(email: email, password: pass).then((_) {
      //   Navigator.pushReplacementNamed(context, '/home/visa');
      // }).catchError((e) {
      //   debugPrint('loginErr: $e');
      // });
    } else if(loginType ==2) {
      print('loginType: $loginType User');
      
      // auth.signInWithEmailAndPassword(email: email, password: pass)




    }

    // if (email == 'admin')
    //   Navigator.pushReplacementNamed(context, '/home/visa');
    // else
    //   Navigator.pushReplacementNamed(context, '/home/user');
  }

  signOut(context) {
    print('logout');
    auth.signOut().then((_) {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
}
