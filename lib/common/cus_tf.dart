import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  controller,
  val,
  label,
  prefixIcon,
  suffixIcon,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
    child: TextFormField(
      controller: controller,
      validator: val,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: label,
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
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
