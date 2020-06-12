import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cusBtn({
  color,
  text,
  action,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 40, right: 40),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: action,
      color: color,
      child: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
