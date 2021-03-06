import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/common/cus_tf.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F4F8),
        appBar: cusAppbar(
          context: context,
          title: 'เพิ่มข้อมูลผลิตภัณฑ์',
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showImage(),
                SizedBox(height: 20.0),
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

  addProduct() {
    print('add product');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        child: Column(
          children: <Widget>[
            customTextField(
              secureText: false,
                controller: proNameCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'ประเภทผลิตภัณฑ์*',
                val: (value) {}),
            customTextField(
              secureText: false,
                controller: proNameCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'ชื่อผลิตภัณฑ์*',
                val: (value) {}),
            customTextField(
              secureText: false,
                controller: proPriceCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'ราคา*(10 บาท/ตัว, 150 บาท/1 โหล, ...)',
                val: (value) {}),
            customTextField(
              secureText: false,
                controller: proSizeCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'ขนาด',
                val: (value) {}),
            customTextField(
              secureText: false,
                controller: proWeightCtrl,
                fillColor: Color(0XFFFFFFFF),
                label: 'น้ำหนัก',
                val: (value) {}),
            SizedBox(height: 25.0),
            cusBtn(
              action: () {
                addProduct();
              },
              color: Theme.of(context).primaryColor,
              text: 'เพิ่มข้อมูล',
            ),
          ],
        ),
      ),
    );
  }
}
