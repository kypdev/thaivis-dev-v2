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
      Navigator.pushNamed(context, '/register/visa');
    }
  }

  userSignup(
    context,
    fname,
    lname,
    email,
    pass,
    conpass,
  ) {
    if (pass != conpass) {
      print('pass not match');
    } else {
      print('start register');
    }
  }

  loginService(context, email) {
    if (email == 'admin')
      Navigator.pushReplacementNamed(context, '/home/visa');
    else
      Navigator.pushReplacementNamed(context, '/home/user');
  }
}
