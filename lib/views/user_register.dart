import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'dart:io';
import 'package:thaivis_dev_v2/common/cus_tf.dart';
import 'package:thaivis_dev_v2/services/auth.dart';
import 'package:path/path.dart';
import 'package:thaivis_dev_v2/services/update_image_profile.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0XFFFFFFFF),
          appBar: cusAppbar(
            context: context,
            title: 'ลงทะเบียนบุคคลทั่วไป',
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  FormRegister(),
                ],
              ),
            ),
          )),
    );
  }
}

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  File _imageFile;
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameCtrl = new TextEditingController();
  TextEditingController lastnameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passCtrl = new TextEditingController();
  TextEditingController conpassCtrl = new TextEditingController();
  Auth _auth = new Auth();
  UpdateImageProfile updateImageProfile = new UpdateImageProfile();
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value.length < 13 || value.isEmpty) {
      return 'รูปแบบอีเมลล์ไม่ถูกต้องหรือกรอกอีเมลของคุณ';
    } else {
      return null;
    }
  }

  // Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  void chooseImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('กล้อง'),
                  onTap: () {
                    setState(() {
                      // file = ImagePicker.pickImage(source: ImageSource.camera);
                      _pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('คลังรูปภาพ'),
                  onTap: () {
                    setState(() {
                      // file = ImagePicker.pickImage(source: ImageSource.gallery);
                      // Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget showImage(BuildContext context) {
    return Center(
        child: _imageFile == null
            ? Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 75.0,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Color(0XFFFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/images/user.png',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 4.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        child: ClipOval(
                          child: Material(
                            color: Color(0xff5663FF),
                            child: InkWell(
                              onTap: () => chooseImage(context),
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 75.0,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 70.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(
                                // snapshot.data,
                                _imageFile),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 4.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        child: ClipOval(
                          child: Material(
                            color: Color(0xff5663FF),
                            child: InkWell(
                              onTap: () => chooseImage(context),
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('ีuserprofile/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    String downloadUrl = await snapshotTask.ref.getDownloadURL();
    
    if (downloadUrl != null) {
      updateImageProfile.updatePro(downloadUrl.toString(), context).then((_) {
        print('update image profile success');
        Navigator.pushReplacementNamed(context, '/home/user');
      }).catchError((e) {
        print('upload error ' + e);
      });
    }
  }

  retister(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      String fname = firstnameCtrl.text.trim();
      String lname = lastnameCtrl.text.trim();
      String email = emailCtrl.text.trim();
      String pass = passCtrl.text;
      String conpass = conpassCtrl.text;
      // print('login: $fname, $lname, $email, $pass, $conpass, ');

      if (pass != conpass) {
        print('alert password not match');
      } else {
        print('password match');
        // await _auth.userSignup(context, fname, lname, email, pass);
        // await uploadImage(context);
        // Navigator.pushReplacementNamed(context, '/home/user');
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
            }).then((user) {
              print('signup: success ${currentUser.user.uid} ok');
              uploadImage(context);
              Navigator.pushReplacementNamed(context, '/home/user');
            }).catchError((e) {
              print('signupErr: $e');
            }));
      }
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
            showImage(context),
            SizedBox(height: 20.0),
            customTextField(
              secureText: false,
              controller: firstnameCtrl,
              label: 'ชื่อ*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {
                if (value.length < 2 || value.isEmpty)
                  return 'ชื่อห้ามว่างหรือต่ำกว่า 2 ตัวอักษร';
                return null;
              },
            ),
            customTextField(
              secureText: false,
              controller: lastnameCtrl,
              label: 'นามสกุล*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {
                if (value.length < 2 || value.isEmpty)
                  return 'นามสกุลห้ามว่างหรือต่ำกว่า 2 ตัวอักษร';
                return null;
              },
            ),
            customTextField(
              secureText: false,
              controller: emailCtrl,
              label: 'อีเมล*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: emailValidator,
            ),
            customTextField(
              secureText: true,
              controller: passCtrl,
              label: 'รหัสผ่าน*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {
                if (value.isEmpty || value.length < 6)
                  return 'รหัสผ่านห้ามว่างหรือห้ามต่ำกว่า 6 ตัวอักษร';
                return null;
              },
            ),
            customTextField(
              secureText: true,
              controller: conpassCtrl,
              label: 'ยืนยันรหัสผ่าน*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {
                if (value.isEmpty || value.length < 6)
                  return 'รหัสผ่านยืนยันห้ามว่างหรือห้ามต่ำกว่า 6 ตัวอักษร';
                return null;
              },
            ),
            SizedBox(height: 20.0),
            cusBtn(
              action: () {
                print(_imageFile);
              },
              color: Color(0XFF1367B8),
              text: 'ลงทะเบียนtest',
            ),
            SizedBox(height: 20.0),
            cusBtn(
              action: () {
                retister(context);
              },
              color: Color(0XFF1367B8),
              text: 'ลงทะเบียน',
            ),
          ],
        ),
      ),
    );
  }
}
