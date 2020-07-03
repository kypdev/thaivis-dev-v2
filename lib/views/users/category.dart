import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            itemCategory(
              img:
                  'http://www.zoda-agency.com/wp-content/uploads/2019/09/instagram-png-instagram-png-logo-1455.png',
              label: 'อาหาร',
            ),

            SizedBox(width: 20.0),

            itemCategory(
              img:
                  'http://www.zoda-agency.com/wp-content/uploads/2019/09/instagram-png-instagram-png-logo-1455.png',
              label: 'อาหาร',
            ),
          ],
        ),
      ],
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(img),
                
              ),
            ),
          ),
          Text(label)
        ],
      ),
    ),
  );
}
