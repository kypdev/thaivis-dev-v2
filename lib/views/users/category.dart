import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/views/users/cat_drink.dart';
import 'package:thaivis_dev_v2/views/users/cat_food.dart';
import 'package:thaivis_dev_v2/views/users/cat_nacklace.dart';
import 'package:thaivis_dev_v2/views/users/cat_service.dart';
import 'package:thaivis_dev_v2/views/users/cat_shirt.dart';
import 'package:thaivis_dev_v2/views/users/cat_weave.dart';

class Category extends StatelessWidget {

  void foodMenu(BuildContext context) { 
    Navigator.push(context, MaterialPageRoute(builder: (context) => CatFood()));
  }

  void drinkMenu(BuildContext context) { 
    Navigator.push(context, MaterialPageRoute(builder: (context) => CatDrink()));
  }

  void shirtMenu(BuildContext context) { 
    Navigator.push(context, MaterialPageRoute(builder: (context) => CatShirt()));
  }

  void necklaceMenu(BuildContext context) { 
    Navigator.push(context, MaterialPageRoute(builder: (context) => CatNecklace()));
  }

  void weaveMenu(BuildContext context) { 
    Navigator.push(context, MaterialPageRoute(builder: (context) => CatWeave()));
  }

  void serviceMenu(BuildContext context) { 
    Navigator.push(context, MaterialPageRoute(builder: (context) => CatService()));
  }

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
                  foodMenu(context);
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
                  drinkMenu(context);
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
                  shirtMenu(context);
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
                  necklaceMenu(context);
                },
                child: itemCategory(
                  img: 'assets/images/user-cat/menu4.png',
                  label: 'เครื่องประดับ',
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
                  weaveMenu(context);
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
                  serviceMenu(context);
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
