import 'package:flutter/material.dart';

class NewPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            cardItem(
              image: 'https://image.makewebeasy.net/makeweb/0/aNSsujWTa/chilli/Picture59.png',
              price: '112',
              proName: 'Ovaltine',
              rating: '4'
            ),
            cardItem(
              image: 'https://image.makewebeasy.net/makeweb/0/aNSsujWTa/chilli/Picture59.png',
              price: '112',
              proName: 'Ovaltine',
              rating: '4'
            ),
            cardItem(
              image: 'https://image.makewebeasy.net/makeweb/0/aNSsujWTa/chilli/Picture59.png',
              price: '112',
              proName: 'Ovaltine',
              rating: '4'
            ),
          ],
        ),
      )
    );
  }
}



Widget cardItem({
  String image,
  String proName,
  String price,
  String rating,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 16.0),
    child: Card(
      elevation: 8.0,
      color: Color(0XFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
            child: Image.network(
              image,
              width: 150.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      proName,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ราคา $price บาท/ตัว',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
          SizedBox(height: 12.0)
        ],
      ),
    ),
  );
}