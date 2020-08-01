import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/common/cus_tf.dart';
import 'package:path/path.dart' as Path;

class AddProduct2 extends StatefulWidget {
  @override
  _AddProduct2State createState() => _AddProduct2State();
}

class _AddProduct2State extends State<AddProduct2> {
  bool loading;
  Future<File> file;
  File tmpFile;
  String _uploadedFileURL;
  final _formKey = GlobalKey<FormState>();
  TextEditingController proNameCtrl = new TextEditingController();
  TextEditingController proDetailCtrl = new TextEditingController();
  TextEditingController proPriceCtrl = new TextEditingController();
  TextEditingController proCatCtrl = new TextEditingController();
  TextEditingController proAddrCtrl = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  Firestore firestore = Firestore.instance;

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
                    });
                    Navigator.pop(context);
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
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(
                    snapshot.data,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://telugukshatriyamatrimony.com/img/no_image_startup.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('products/${Path.basename(tmpFile.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(tmpFile);
    await uploadTask.onComplete;
    print('upload success');
    _uploadedFileURL = await storageReference.getDownloadURL();
    print('get img url success');
  }

  addProduct() async {
    if (_formKey.currentState.validate()) {
      user = await auth.currentUser();
      var uid = user.uid;

      String proName = proNameCtrl.text;
      String proDetail = proDetailCtrl.text;
      String proPrice = proPriceCtrl.text;
      String proCat = proCatCtrl.text;
      String proAddr = proAddrCtrl.text;

      print('addpro: $proName, $proDetail, $proPrice, $proCat, $proAddr');

      setState(() {
          loading = true;
        });

        await uploadImage();
        print('imgurl: $_uploadedFileURL');

        firestore.collection('products').add({
          'name': proName,
          'detail': proDetail,
          'price': proPrice,
          'cat': proCat,
          'addr': proAddr,
          'visaid': uid,
          'img': _uploadedFileURL
        });

        setState(() {
          loading = false;
        });

      // if (proCat == '1') {
      //   print('chkcat: 1');

      //   setState(() {
      //     loading = true;
      //   });

      //   await uploadImage();
      //   print('imgurl: $_uploadedFileURL');

      //   firestore.collection('foods').add({
      //     'name': proName,
      //     'detail': proDetail,
      //     'price': proPrice,
      //     'cat': proCat,
      //     'addr': proAddr,
      //     'visaid': uid,
      //     'img': _uploadedFileURL
      //   });

      //   setState(() {
      //     loading = false;
      //   });


      // }else if(proCat == '2'){


      //    setState(() {
      //     loading = true;
      //   });

      //   await uploadImage();
      //   print('imgurl: $_uploadedFileURL');

      //   firestore.collection('drinks').add({
      //     'name': proName,
      //     'detail': proDetail,
      //     'price': proPrice,
      //     'cat': proCat,
      //     'addr': proAddr,
      //     'visaid': uid,
      //     'img': _uploadedFileURL
      //   });

      //   setState(() {
      //     loading = false;
      //   });

      // }else if(proCat == '3'){

      //   setState(() {
      //     loading = true;
      //   });

      //   await uploadImage();
      //   print('imgurl: $_uploadedFileURL');

      //   firestore.collection('costumes').add({
      //     'name': proName,
      //     'detail': proDetail,
      //     'price': proPrice,
      //     'cat': proCat,
      //     'addr': proAddr,
      //     'visaid': uid,
      //     'img': _uploadedFileURL
      //   });

      //   setState(() {
      //     loading = false;
      //   });

      // }else if(proCat == '4'){

      //   setState(() {
      //     loading = true;
      //   });

      //   await uploadImage();
      //   print('imgurl: $_uploadedFileURL');

      //   firestore.collection('accessories').add({
      //     'name': proName,
      //     'detail': proDetail,
      //     'price': proPrice,
      //     'cat': proCat,
      //     'addr': proAddr,
      //     'visaid': uid,
      //     'img': _uploadedFileURL
      //   });

      //   setState(() {
      //     loading = false;
      //   });

      // }else if(proCat == '5'){
      //   setState(() {
      //     loading = true;
      //   });

      //   await uploadImage();
      //   print('imgurl: $_uploadedFileURL');

      //   firestore.collection('wickers').add({
      //     'name': proName,
      //     'detail': proDetail,
      //     'price': proPrice,
      //     'cat': proCat,
      //     'addr': proAddr,
      //     'visaid': uid,
      //     'img': _uploadedFileURL
      //   });

      //   setState(() {
      //     loading = false;
      //   });
      // }else{
      //   setState(() {
      //     loading = true;
      //   });

      //   await uploadImage();
      //   print('imgurl: $_uploadedFileURL');

      //   firestore.collection('services').add({
      //     'name': proName,
      //     'detail': proDetail,
      //     'price': proPrice,
      //     'cat': proCat,
      //     'addr': proAddr,
      //     'visaid': uid,
      //     'img': _uploadedFileURL
      //   });

      //   setState(() {
      //     loading = false;
      //   });

      // }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F4F8),
        appBar: cusAppbar(
          context: context,
          title: 'เพิ่มข้อมูลผลิตภัณฑ์(2)',
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 12.0),
                        showImage(),
                        SizedBox(height: 12.0),
                        cusBtn(
                          action: () => chooseImage(context),
                          text: 'เลือกรูปสินค้า',
                          color: Colors.blue,
                        ),
                        SizedBox(height: 20.0),
                        customTextField(
                            secureText: false,
                            controller: proNameCtrl,
                            fillColor: Color(0XFFFFFFFF),
                            label: 'ชื่อสินค้า*',
                            val: (value) {
                              if (value.isEmpty) return 'ชื่อสินค้าห้ามว่าง!!!';
                              return null;
                            }),
                        customTextField(
                            secureText: false,
                            controller: proDetailCtrl,
                            fillColor: Color(0XFFFFFFFF),
                            label: 'รายละเอียดสินค้า*',
                            val: (value) {
                              if (value.isEmpty) return 'ชื่อสินค้าห้ามว่าง!!!';
                              return null;
                            }),
                        customTextField(
                            secureText: false,
                            controller: proPriceCtrl,
                            fillColor: Color(0XFFFFFFFF),
                            label: 'ราคา*(10 บาท/ตัว, 150 บาท/1 โหล, ...)',
                            val: (value) {
                              if (value.isEmpty) return 'ราคาสินค้าห้ามว่าง!!!';
                              return null;
                            }),
                        customTextField(
                            secureText: false,
                            controller: proCatCtrl,
                            fillColor: Color(0XFFFFFFFF),
                            label: 'หมวดหมู่*',
                            val: (value) {
                              if (value.isEmpty) return 'หมวดหมู่สินค้าห้ามว่าง!!!';
                              return null;
                            }),
                        customTextField(
                            secureText: false,
                            controller: proAddrCtrl,
                            fillColor: Color(0XFFFFFFFF),
                            label: 'ที่อยู่*',
                            val: (value) {
                              if (value.isEmpty) return 'ที่อยู่สินค้าห้ามว่าง!!!';
                              return null;
                            }),
                        SizedBox(height: 25.0),
                        cusBtn(
                          action: () {
                            addProduct();
                          },
                          color: Theme.of(context).primaryColor,
                          text: 'เพิ่มข้อมูล',
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
                      visible: loading,
                      child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}

class FormAddProduct extends StatefulWidget {
  @override
  _FormAddProductState createState() => _FormAddProductState();
}

class _FormAddProductState extends State<FormAddProduct> {
  TextEditingController proNameCtrl = new TextEditingController();
  TextEditingController proDetailCtrl = new TextEditingController();
  TextEditingController proPriceCtrl = new TextEditingController();
  TextEditingController proCatCtrl = new TextEditingController();
  TextEditingController proAddrCtrl = new TextEditingController();
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  final _formKey = GlobalKey<FormState>();

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
                  onTap: () async {
                    var _file =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    setState(() {
                      tmpFile = _file;
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('คลังรูปภาพ'),
                  onTap: () async {
                    var _file = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    setState(() {
                      tmpFile = _file;
                    });
                    Navigator.pop(context);
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
          // base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(
                    snapshot.data,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://telugukshatriyamatrimony.com/img/no_image_startup.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Text(
                  'คุณยังไม่ได้เลือกรูปสินค้า',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  addProduct() {
    if (_formKey.currentState.validate()) {
      String proName = proNameCtrl.text;
      String proDetail = proDetailCtrl.text;
      String proPrice = proPriceCtrl.text;
      String proCat = proCatCtrl.text;
      String proAddr = proAddrCtrl.text;

      print('$proName, $proDetail, $proPrice, $proCat, $proAddr');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            showImage(),
            SizedBox(height: 20.0),
            cusBtn(
              action: () => chooseImage(context),
              text: 'เลือกรูปสินค้า',
              color: Colors.blue,
            ),
            SizedBox(height: 20.0),
            customTextField(
                secureText: false,
                controller: proNameCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'ชื่อสินค้า*',
                val: (value) {
                  if (value.isEmpty) return 'ชื่อสินค้าห้ามว่าง!!!';
                  return null;
                }),
            customTextField(
                secureText: false,
                controller: proDetailCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'รายละเอียดสินค้า*',
                val: (value) {
                  if (value.isEmpty) return 'ชื่อสินค้าห้ามว่าง!!!';
                  return null;
                }),
            customTextField(
                secureText: false,
                controller: proPriceCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'ราคา*(10 บาท/ตัว, 150 บาท/1 โหล, ...)',
                val: (value) {
                  if (value.isEmpty) return 'ราคาสินค้าห้ามว่าง!!!';
                  return null;
                }),
            customTextField(
                secureText: false,
                controller: proCatCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'หมวดหมู่*',
                val: (value) {
                  if (value.isEmpty) return 'หมวดหมู่สินค้าห้ามว่าง!!!';
                  return null;
                }),
            customTextField(
                secureText: false,
                controller: proAddrCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'ที่อยู่*',
                val: (value) {
                  if (value.isEmpty) return 'ที่อยู่สินค้าห้ามว่าง!!!';
                  return null;
                }),
            SizedBox(height: 25.0),
            cusBtn(
              action: () {
                // addProduct();
              },
              color: Theme.of(context).primaryColor,
              text: 'เพิ่มข้อมูล',
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
