import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  SharedPreferences pref;

  checkLogin(context) async {
    pref = await SharedPreferences.getInstance();

    var loginFlag = pref.getInt('loginFlag');

    if (loginFlag == 1) {
      debugPrint('login screen');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }

    debugPrint('login: $loginFlag');
  }

  userRegister(context, loginType) {
    if (loginType == 2) {
      Navigator.pushNamed(context, '/register/user');
    } else {
      debugPrint('vis register');
    }
  }
}
