import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/common/cus_tf.dart';

class AddProduct2 extends StatefulWidget {
  @override
  _AddProduct2State createState() => _AddProduct2State();
}

class _AddProduct2State extends State<AddProduct2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F4F8),
        appBar: cusAppbar(
          context: context,
          title: 'เพิ่มข้อมูลผลิตภัณฑ์(2)',
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormAddProduct(),
              ],
            ),
          ),
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
  TextEditingController proPriceCtrl = new TextEditingController();
  TextEditingController proSizeCtrl = new TextEditingController();
  TextEditingController proWeightCtrl = new TextEditingController();
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
    print('add product');
    if (_formKey.currentState.validate()) {}
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
                controller: proNameCtrl,
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
                controller: proSizeCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'หมวดหมู่*',
                val: (value) {
                  if (value.isEmpty) return 'หมวดหมู่สินค้าห้ามว่าง!!!';
                  return null;
                }),
            customTextField(
                secureText: false,
                controller: proWeightCtrl,
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
    );
  }
}
