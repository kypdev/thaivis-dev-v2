import 'package:flutter/material.dart';

class PriceDetail extends StatefulWidget {
  @override
  _PriceDetailState createState() => _PriceDetailState();
}

class _PriceDetailState extends State<PriceDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: Text('รายละเอียดสินค้า'),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.0),
              cardItem(
              image: 'https://image.makewebeasy.net/makeweb/0/aNSsujWTa/chilli/Picture59.png',
              price: '112',
              proName: 'Ovaltine',
              rating: '4'
            ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget cardItem({
  String image,
  String proName,
  String price,
  String rating,
}) {
  return Column(
    children: <Widget>[
      Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
            child: Image.network(
              image,
              width: 150.0,
            ),
          ),  
    ],
  );
}