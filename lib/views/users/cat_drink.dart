import 'package:flutter/material.dart';

var visaImg =
    'https://images.unsplash.com/photo-1579349443343-73da56a71a20?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80';

class CatDrink extends StatefulWidget {
  @override
  _CatDrinkState createState() => _CatDrinkState();
}

class _CatDrinkState extends State<CatDrink> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0XFFcaf0f8),
          appBar: AppBar(
            title: Text(
              'เครื่องดื่ม',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                itemVisa(img: visaImg, label: 'วิสาหกิจ กทม.', addr: 'กทม หนองแขม'),
              ],
            ),
          )),
    );
  }
}

Widget itemVisa({String img, String label, String addr}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0XFFF0F4F8),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(img),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF7D8694),
                  ),
                ),
                Text(
                  addr,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF7D8694),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
