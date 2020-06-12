import 'package:flutter/cupertino.dart';

class Visa {
  void goManageProduct(context){
    Navigator.pushNamed(context, '/visa/manage');
  }
  
  void goAddProduct(context){
    Navigator.pushNamed(context, '/visa/addPro');
  }
  
}