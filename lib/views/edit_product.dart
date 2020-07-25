import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/common/cus_tf.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  Future<File> file;
  File tmpFile;
  final _formKey = GlobalKey<FormState>();
  TextEditingController proNameCtrl = new TextEditingController();
  TextEditingController proDetailCtrl = new TextEditingController();
  TextEditingController proPriceCtrl = new TextEditingController();
  TextEditingController proCatCtrl = new TextEditingController();
  TextEditingController proAddrCtrl = new TextEditingController();

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F4F8),
        appBar: cusAppbar(
          context: context,
          title: 'แก้ไขข้อมูลสินค้า',
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                        if (value.isEmpty) return 'รายละเอียดห้ามว่าง!!!';
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: cusBtn(
                          action: () {},
                          color: Colors.lightGreen,
                          text: 'แก้ไขข้อมูล',
                        ),
                      ),
                      Expanded(
                        child: cusBtn(
                          action: () {},
                          color: Colors.red,
                          text: 'ลบข้อมูล',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
