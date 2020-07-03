import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/common/cus_tf.dart';
import 'package:thaivis_dev_v2/services/update_image_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';


class VisaRegister extends StatefulWidget {
  @override
  _VisaRegisterState createState() => _VisaRegisterState();
}

class _VisaRegisterState extends State<VisaRegister> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0XFFFFFFFF),
          appBar: cusAppbar(
            context: context,
            title: 'ลงทะเบียนวิสาหากิจชุมชน',
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FormRegister(),
                  ],
                ),
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

  TextEditingController visanameCtrl = new TextEditingController();
  TextEditingController addrNumCtrl = new TextEditingController();
  TextEditingController firstnameCtrl = new TextEditingController();
  TextEditingController roadCtrl = new TextEditingController();
  TextEditingController subDistrictCtrl = new TextEditingController();
  TextEditingController districtCtrl = new TextEditingController();
  TextEditingController provinceCtrl = new TextEditingController();
  TextEditingController zipCodeCtrl = new TextEditingController();
  TextEditingController telCtrl = new TextEditingController();
  TextEditingController locationCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passCtrl = new TextEditingController();
  TextEditingController conpassCtrl = new TextEditingController();

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  final _formKey = GlobalKey<FormState>();
  File _imageFile;
  UpdateImageProfile updateImageProfile = new UpdateImageProfile();
  FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;


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
        .child('ีvisaprofile/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    String downloadUrl = await snapshotTask.ref.getDownloadURL();

    if (downloadUrl != null) {
      updateImageProfile
          .updateVisaPro(downloadUrl.toString(), context)
          .then((val) {
        print('update image profile success');
        Navigator.pushReplacementNamed(context, '/home/user');
      }).catchError((e) {
        print('upload error ' + e);
      });
    }
  }

  void retister(BuildContext context) {
    if (_formKey.currentState.validate()) {
      String visaName = visanameCtrl.text.trim();
      String addrNo = addrNumCtrl.text.trim();
      String road = roadCtrl.text.trim();
      String subDistrict = subDistrictCtrl.text.trim();
      String district = districtCtrl.text.trim();
      String province = provinceCtrl.text.trim();
      String zipCode = zipCodeCtrl.text.trim();
      String tel = telCtrl.text.trim();
      String location = locationCtrl.text.trim();
      String email = emailCtrl.text.trim();
      String pass = passCtrl.text.trim();
      String conpass = conpassCtrl.text.trim();

      if (pass != conpass) {
        print('show alert pass not match');
      } else {
        print('start register');

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
              }).then((user) {
                print('signup success ${currentUser.user.uid}');
                uploadImage(context);
              // Navigator.pushReplacementNamed(context, '/home/visa');
              }).catchError((e) => print('err: $e')));

        
      }
    }

    // auth.visaSignup(context, visaName, addrNo, road, subDistrict, district, province, zipCode, tel, location, email, pass, conpass);
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
            SizedBox(height: 16.0),
            customTextField(
              secureText: false,
              controller: visanameCtrl,
              label: 'ชื่อวิสาหกิจชุมชน*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {
                if (value.isEmpty || value.length < 5)
                  return 'ชื่อวิสหากิจห้ามว่างหรือต่ำกว่า 5 ตัวอักษร';
                return null;
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: customTextField(
                    secureText: false,
                    controller: addrNumCtrl,
                    label: 'ที่อยู่เลขที่*',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Color(0XFFF0F4F8),
                    val: (value) {
                      if (value.isEmpty) return 'เลขที่ที่อยู่วิสหากิจห้ามว่าง';
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: customTextField(
                    secureText: false,
                    controller: roadCtrl,
                    label: 'ถนน*',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Color(0XFFF0F4F8),
                    val: (value) {},
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: customTextField(
                    secureText: false,
                    controller: subDistrictCtrl,
                    label: 'ตำบล*',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Color(0XFFF0F4F8),
                    val: (value) {
                      if (value.isEmpty || value.length < 4)
                        return 'ตำบลห้ามว่างหรือต่ำกว่า 4 ตัวอักษร';
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: customTextField(
                    secureText: false,
                    controller: districtCtrl,
                    label: 'อำเภอ*',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Color(0XFFF0F4F8),
                    val: (value) {
                      if (value.isEmpty || value.length < 4)
                        return 'อำเภอห้ามว่างหรือต่ำกว่า 4 ตัวอักษร';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            customTextField(
              secureText: false,
              controller: provinceCtrl,
              label: 'จังหวัด*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {
                if (value.isEmpty || value.length < 4)
                  return 'จังหวัดห้ามว่างหรือต่ำกว่า 4 ตัวอักษร';
                return null;
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: customTextField(
                    secureText: false,
                    controller: zipCodeCtrl,
                    label: 'รหัสไปรษณีย์*',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Color(0XFFF0F4F8),
                    val: (value) {
                      if (value.isEmpty || value.length < 5)
                        return 'รหัสไปรษณย์ห้ามว่างหรือต่ำกว่า 5 ตัวอักษร';
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: customTextField(
                    secureText: false,
                    controller: telCtrl,
                    label: 'เบอร์โทรศัพท์*',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Color(0XFFF0F4F8),
                    val: (value) {
                      if (value.isEmpty || value.length < 10)
                        return 'เบอร์โทรศัพท์ห้ามว่างหรือต่ำกว่า 10 ตัวอักษร';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            customTextField(
              secureText: false,
              controller: locationCtrl,
              label: 'ตำแหน่งที่ตั้ง*',
              prefixIcon: Icon(Icons.person),
              fillColor: Color(0XFFF0F4F8),
              val: (value) {},
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
                  return 'รหัสผ่านห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
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
                  return 'รหัสผ่านยืนยันห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
                return null;
              },
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


