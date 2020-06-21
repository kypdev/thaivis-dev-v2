import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  controller,
  val,
  label,
  prefixIcon,
  suffixIcon,
  fillColor,
  secureText
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0, top: 10),
    child: TextFormField(
      obscureText: secureText,
      controller: controller,
      validator: val,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: label,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}
