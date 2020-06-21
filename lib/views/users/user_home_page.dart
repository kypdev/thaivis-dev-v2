import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/views/users/destination.dart';

class UserHomePage extends StatelessWidget {
  final Destination destination;

  const UserHomePage({Key key, this.destination}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'วิสาหกิจชุมชน (บุคคลทั่วไป)',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox.expand(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            child: Center(
              child: Text('tap here home'),
            ),
          ),
        ),
      ),
    );
  }
}
