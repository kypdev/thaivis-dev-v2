import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/common/cus_tf.dart';
import 'package:thaivis_dev_v2/services/auth.dart';

final Color scaffColor = Color(0xfff0f4f8);
final Auth _auth = new Auth();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo(),
              LoginForm(),
            ],
          ),
        ),
      )),
    );
  }
}

Widget logo() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 60.0),
    child: Image.asset(
      'assets/images/logo.png',
      width: 160.0,
    ),
  );
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  FirebaseUser user;

  String emailVal(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value.length < 5) {
      return 'อีเมลล์ไม่ถูกต้อง';
    } else {
      return null;
    }
  }

  int loginType = 1;

  login() async {
    if (_formKey.currentState.validate()) {
      String email = emailCtrl.text.trim();
      String pass = passwordCtrl.text;
      if (loginType == 2) {
        // print('val ok');
        // ! ######## user login ##########
        // print('$email // $pass');

        auth
            .signInWithEmailAndPassword(email: email, password: pass)
            .catchError((e) => print('loginerr: $e'))
            .then((currentUser) {
          print('userlogin: ${currentUser.user.uid}');

          firestore
              .collection('users')
              .where('uid', isEqualTo: currentUser.user.uid)
              .getDocuments()
              .then((docs) {
            print('docs: ${docs.documents[0].data['role']}');
            if (docs.documents[0].data['role'] == 'user') {
              print('go to user screen');
              Navigator.pushReplacementNamed(context, '/home/user');
            } else {
              print('alert cannot login');
            }
          });
        });

        // ! ######## user login ##########
      } else if (loginType == 1) {
        // print('visa login');

        // ! ######## visa login ##########
        // print('$email // $pass');

        auth
            .signInWithEmailAndPassword(email: email, password: pass)
            .catchError((e) => print('loginerr: $e'))
            .then((currentUser) {
          print('userlogin: ${currentUser.user.uid}');

          firestore
              .collection('visa')
              .where('uid', isEqualTo: currentUser.user.uid)
              .getDocuments()
              .then((docs) {
            print('docs: ${docs.documents[0].data['role']}');
            if (docs.documents[0].data['role'] == 'visa') {
              print('go to user screen');
              Navigator.pushReplacementNamed(context, '/home/visa');
            } else {
              print('alert cannot login');
            }
          });
        });

        // ! ######## visa login ##########

      }
    }
    // _auth.signWighEmail(context, email, pass, loginType);
  }

  register() {
    print('register: $loginType');
    if (loginType == 1) {
      Navigator.pushNamed(context, '/register/visa');
    } else if (loginType == 2) {
      Navigator.pushNamed(context, '/register/user');
    } else {
      print('login type not found');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: <Widget>[
            customTextField(
              secureText: false,
              fillColor: Color(0XFFF0F4F8),
              controller: emailCtrl,
              prefixIcon: Icon(Icons.email),
              label: 'อีเมล',
              val: emailVal,
            ),
            SizedBox(height: 10),
            customTextField(
              secureText: true,
              fillColor: Color(0XFFF0F4F8),
              controller: passwordCtrl,
              prefixIcon: Icon(Icons.lock),
              label: 'รหัสผ่าน',
              val: (value) {
                if (value.isEmpty || value.length < 6) {
                  return 'รหัสผ่านห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
                }
                return null;
              },
            ),
            SizedBox(height: 35),
            cusBtn(
              action: () => login(),
              text: 'เข้าใช้งาน',
              color: Color(0xff1367b8),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: loginType,
                  onChanged: (value) {
                    setState(() {
                      loginType = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'วิสาหากิจชุมชน',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width: 16),
                Radio(
                  value: 2,
                  groupValue: loginType,
                  onChanged: (value) {
                    setState(() {
                      loginType = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'บุคคลทั่วไป',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: register,
              child: Text(
                'ลงทะเบียนผู้ใช้งานใหม่',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
