import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  print('food');
                },
                child: itemCategory(
                  img: 'assets/images/user-cat/menu1.png',
                  label: 'อาหาร',
                ),
              ),
              SizedBox(width: 20.0),
              InkWell(
                onTap: () {
                  print('drink');
                },
                child: itemCategory(
                  img: 'assets/images/user-cat/menu2.png',
                  label: 'เครื่องดื่ม',
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  print('shirt');
                },
                child: itemCategory(
                  img: 'assets/images/user-cat/menu3.png',
                  label: 'เครื่องแต่งกาย',
                ),
              ),
              SizedBox(width: 20.0),
              InkWell(
                onTap: () {
                  print('necklace');
                },
                child: itemCategory(
                  img: 'assets/images/user-cat/menu4.png',
                  label: 'ขอบประดับ',
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  print('weave');
                },
                child: itemCategory(
                  img: 'assets/images/user-cat/menu5.png',
                  label: 'เครื่องจักสาน',
                ),
              ),
              SizedBox(width: 20.0),
              InkWell(
                onTap: () {
                  print('service');
                },
                child: itemCategory(
                  img: 'assets/images/user-cat/menu6.png',
                  label: 'บริการ',
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

Widget itemCategory({String img, String label}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.lightBlue,
      ),
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
              color: Color(0XFF347DC2),
            ),
          )
        ],
      ),
    ),
  );
}
