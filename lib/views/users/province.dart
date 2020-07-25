import 'package:flutter/material.dart';

// Future<void> loadProvince() async {

//   return Provinces.fromJson(json)
// }

var provinces = [
  {"id": 1, "name": "กรุงเทพฯ"},
  {"id": 2, "name": "สมุทรสาคร"},
  {"id": 3, "name": "สมุทรสงคราม"}
];

class Province extends StatelessWidget {
  void showProvince(BuildContext context) async {
    print('provinces: ' + provinces.toString());
    // showModalBottomSheet(
    //     context: context,
    //     builder: (builder) {
    //       return
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0XFFF0F4F8),
          // appBar: AppBar(
          //   title: Text('Title'),
          // ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'จังหวัด',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Color(0XFF367EC3),
                      fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0XFFFFFFFF),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'กรุงเทพฯ',
                        style: TextStyle(
                          fontSize: 28.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        // color: Colors.amber,
                        child: IconButton(
                          icon: Icon(Icons.arrow_drop_down),
                          onPressed: () => showProvince(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
