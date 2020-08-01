import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/common/cus_tf.dart';

class PriceDetail extends StatefulWidget {
  final img;
  final title;
  final detail;
  final price;
  final visaname;

  const PriceDetail(
      {Key key, this.img, this.title, this.detail, this.price, this.visaname})
      : super(key: key);
  @override
  _PriceDetailState createState() => _PriceDetailState();
}

class _PriceDetailState extends State<PriceDetail> {
  var rating = 3.0;
  TextEditingController reviewsCtrl = new TextEditingController();

  sendReview() {
    print('send reviews');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F4F8),
        appBar: cusAppbar(
          context: context,
          title: 'รายละเอียดสินค้า',
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.img,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'ชื่อสินค้า: ${widget.title}',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        '${widget.price} -',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  Text(
                    'รายละเอียดสินค้า: ${widget.detail}',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'ชื่อวิสาหกิจ: xxxxxxxxxxxxxxx',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 60.0),
                  Center(
                    child: FlutterRatingBar(
                      initialRating: 3,
                      fillColor: Colors.amber,
                      borderColor: Colors.amber.withAlpha(50),
                      allowHalfRating: true,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'ความคิดเห็น',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  customTextField(
                      secureText: false,
                      controller: reviewsCtrl,
                      fillColor: Color(0XFFFFFFFF),
                      val: (value) {
                        if (value.isEmpty) return 'คุณไม่ได้กรอกความคิดเห็น';
                        return null;
                      }),
                  SizedBox(height: 20.0),
                  cusBtn(
                    action: () {
                      sendReview();
                    },
                    color: Theme.of(context).primaryColor,
                    text: 'ส่ง',
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
