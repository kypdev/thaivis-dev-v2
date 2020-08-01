import 'package:flutter/cupertino.dart';

class Visa {

  void goVisaProfile(context) {
    Navigator.pushNamed(context, '/visa/profile');
  }

  void goManageProduct(context) {
    Navigator.pushNamed(context, '/visa/manage');
  }

  void goAddProduct(context) {
    Navigator.pushNamed(context, '/visa/addPro');
  }
  
}
