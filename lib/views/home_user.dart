import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        appBar: cusAppbar(
          context: context,
          title: 'วิสาหกิจชุมชน (บุคคลทั่วไป)',
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // showImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}