import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cusAppbar({
  context,
  String title,
}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}
