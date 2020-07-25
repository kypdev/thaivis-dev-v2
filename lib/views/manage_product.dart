import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/views/add_product%202.dart';
import 'package:thaivis_dev_v2/views/edit_product.dart';

class ManageProduct extends StatefulWidget {
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {

  addProduct() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddProduct2()));
  }

  editProduct() {
    print('edit product');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProduct()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F4F8),
        appBar: cusAppbar(
          context: context,
          title: 'จัดการข้อมูลผลิตภัณฑ์',
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: addProduct,
          backgroundColor: Color(0XFF1367B8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          label: Text(
            'เพิ่มข้อมูล',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onLongPress: () {
                      editProduct();
                    },
                    child: cardItem(
                      image: 'assets/images/shirt.png',
                      price: '900',
                      proName: 'เสื้อทีมแมนยู',
                      rating: '5.1',
                    ),
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: cardItem(
                  //         image: 'assets/images/shirt.png',
                  //         price: '900',
                  //         proName: 'เสื้อทีมแมนยู',
                  //         rating: '5.1',
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: InkWell(
                  //         onLongPress: (){
                  //           print('edit product');
                  //         },
                  //                                 child: cardItem(
                  //           image: 'assets/images/olo.jpg',
                  //           price: '250',
                  //           proName: 'เสื้อทีมแมนยู',
                  //           rating: '2.1',
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
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
  return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Card(
      elevation: 8.0,
      color: Color(0XFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
            child: Image.asset(
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
                Container(
                  decoration: BoxDecoration(
                    color: Color(0XFFFF6969),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 7, right: 7, top: 2, bottom: 2),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        Text(
                          rating,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
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
