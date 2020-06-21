import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'dart:io';
import 'package:thaivis_dev_v2/common/cus_tf.dart';
import 'package:thaivis_dev_v2/services/auth.dart';

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

  void chooseImage() {
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
                      file = ImagePicker.pickImage(source: ImageSource.camera);
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('คลังรูปภาพ'),
                  onTap: () {
                    setState(() {
                      file = ImagePicker.pickImage(source: ImageSource.gallery);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Stack(
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
                          snapshot.data,
                        ),
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
                          onTap: chooseImage,
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
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Stack(
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
                          onTap: chooseImage,
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
          );
        }
      },
    );
  }

  TextEditingController firstnameCtrl = new TextEditingController();
  TextEditingController lastnameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passCtrl = new TextEditingController();
  TextEditingController conpassCtrl = new TextEditingController();
  Auth _auth = new Auth();
  
  retister() {
    
    String fname = firstnameCtrl.text.trim();
    String lname = lastnameCtrl.text.trim();
    String email = emailCtrl.text.trim();
    String pass = passCtrl.text;
    String conpass = conpassCtrl.text;

    _auth.userSignup(context, fname, lname, email, pass, conpass);

    
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: <Widget>[
            showImage(),
            SizedBox(height: 20.0),
            customTextField(
              controller: firstnameCtrl,
              label: 'ชื่อ*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {},
            ),
            customTextField(
              controller: lastnameCtrl,
              label: 'นามสกุล*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {},
            ),
            customTextField(
              controller: emailCtrl,
              label: 'อีเมล*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {},
            ),
            customTextField(
              controller: passCtrl,
              label: 'รหัสผ่าน*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {},
            ),
            customTextField(
              controller: conpassCtrl,
              label: 'ยืนยันรหัสผ่าน*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {},
            ),
            SizedBox(height: 20.0),
            cusBtn(
              action: () {
                retister();
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
