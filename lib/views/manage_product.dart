import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/views/add_product2.dart';
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

  String uid;

  userId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uuid = user.uid.toString();
    print(uuid);
    setState(() {
      uid = uuid;
    });
  }

  @override
  void initState() {
    super.initState();
    userId();
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
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('products')
              .where('visaid', isEqualTo: uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('load');
                case ConnectionState.active:
                  return ListView(
                    children:
                        snapshot.data.documents.map((DocumentSnapshot docs) {
                      return cardItem(
                        image: docs['img'],
                        proName: docs['name'],
                        price: docs['price'],
                      );
                    }).toList(),
                  );
                case ConnectionState.done:
                  return Text('done');
                case ConnectionState.none:
                  return Text('none');
              }
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: snapshot.data.documents.map((DocumentSnapshot docs) {
                  return cardItem(
                    image: docs['img'],
                    proName: docs['name'],
                    price: docs['price'],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget cardItem({
  String image,
  String proName,
  String price,
  // String rating,
}) {
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
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                    image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
                  ),
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
                // Container(
                //   decoration: BoxDecoration(
                //     color: Color(0XFFFF6969),
                //     borderRadius: BorderRadius.circular(16.0),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //         left: 7, right: 7, top: 2, bottom: 2),
                //     child: Row(
                //       children: <Widget>[
                //         Icon(
                //           Icons.star,
                //           color: Colors.white,
                //           size: 20.0,
                //         ),
                //         Text(
                //           rating,
                //           style: TextStyle(
                //             fontSize: 18.0,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 12.0)
        ],
      ),
    ),
  );
}
