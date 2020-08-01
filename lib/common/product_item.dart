import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {

  final image;
  final proName;
  final price;

  const ProductItem({Key key, this.image, this.proName, this.price}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Card(
      elevation: 8.0,
      color: Color(0XFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 15.0, left: 20.0, right: 20.0),
            child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                    image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
                  ),
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'ชื่อสินค้า: ',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        Text(
                          proName,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'ราคา: ',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        ),
                        
                        Text(
                          '$price บาท',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
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
}