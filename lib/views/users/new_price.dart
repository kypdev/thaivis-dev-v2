import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/views/users/price_detail.dart';

class NewPrice extends StatefulWidget {
  @override
  _NewPriceState createState() => _NewPriceState();
}

class _NewPriceState extends State<NewPrice> {
  showPriceDetail(context, String img, String title, String price, String detail, String visaname, ) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PriceDetail(
          img: img,
          title: title,
          price: price,
          detail: detail,
          visaname: visaname,
        )));
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
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('products')
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
                      return InkWell(
                        onTap: (){
                          var img = docs['img'];
                          var title = docs['name'];
                          var price = docs['price'];
                          var detail = docs['detail'];
                          var visaname = 'visa name';
                          showPriceDetail(context, img, title, price, detail, visaname);
                        },
                                              child: cardItem(
                          image: docs['img'],
                          proName: docs['name'],
                          price: docs['price'],
                        ),
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
    padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 16.0),
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
              ],
            ),
          ),
          SizedBox(height: 12.0)
        ],
      ),
    ),
  );
}
