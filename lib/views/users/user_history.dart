import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/views/users/destination.dart';

class UserHistory extends StatelessWidget {
  final Destination destination;

  const UserHistory({Key key, this.destination}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ประวัติ',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
