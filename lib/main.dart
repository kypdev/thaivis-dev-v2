import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/views/add_product.dart';
import 'package:thaivis_dev_v2/views/home_visa.dart';
import 'package:thaivis_dev_v2/views/login_screen.dart';
import 'package:thaivis_dev_v2/views/manage_product.dart';
import 'package:thaivis_dev_v2/views/user_bottom_nav_bar.dart';
import 'package:thaivis_dev_v2/views/visa_profile.dart';
import 'package:thaivis_dev_v2/views/visa_register.dart';
import 'views/splash_screen.dart';
import 'views/user_register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff1B64AA),
        fontFamily: 'THSarabun',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register/user': (context) => UserRegister(),
        '/register/visa': (context) => VisaRegister(),
        '/home/visa': (context) => HomeVisa(),
        '/home/user': (context) => UserBottomNavHome(),
        '/visa/manage': (context) => ManageProduct(),
        '/visa/addPro': (context) => AddProduct(),
        '/visa/profile': (context) => VisaProfile(),
      },
    );
  }
}