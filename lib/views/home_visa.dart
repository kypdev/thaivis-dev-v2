import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/services/auth.dart';
import 'package:thaivis_dev_v2/services/visa.dart';

class HomeVisa extends StatefulWidget {
  @override
  _HomeVisaState createState() => _HomeVisaState();
}

class _HomeVisaState extends State<HomeVisa> {
  final Visa _visa = new Visa();
  Auth auth = new Auth();

  Widget showImage() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 75.0,
          child: CircleAvatar(
            radius: 70.0,
            backgroundColor: Color(0XFFFFFFFF),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/user.png',
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'กลุ่มแม่บ้านเกษตรตำบลตลาดกระทุ่มแบน',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff5995CD),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        appBar: AppBar(
          title: Text(
            'วิสาหกิจชุมชน',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  showImage(),
                  SizedBox(height: 16.0),
                  cardMenu(
                    image: 'assets/images/menu.png',
                    text: 'จัดการข้อมูลวิสาหกิจชุมชน',
                    action: () {},
                  ),
                  cardMenu(
                    image: 'assets/images/menu.png',
                    text: 'จัดการข้อมูลผลิตภัณฑ์ชุมชน',
                    action: () => _visa.goManageProduct(context),
                  ),
                  cardMenu(
                    image: 'assets/images/menu.png',
                    text: 'ผลการตอบรับผลิตภัณฑ์ชุมชน',
                    action: () {},
                  ),
                  cardMenu(
                    image: 'assets/images/menu.png',
                    text: 'ออกจากระบบ',
                    action: () {
                      auth.signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget cardMenu({
  image,
  text,
  action,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
    child: InkWell(
      onTap: action,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color(0xff1367B8),
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Image.asset(
                image,
                width: 80.0,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ),
  );
}
