import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}