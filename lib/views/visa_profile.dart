import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/common/cus_appbar.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';

class VisaProfile extends StatefulWidget {
  @override
  _VisaProfileState createState() => _VisaProfileState();
}

class _VisaProfileState extends State<VisaProfile> {
  String userID;
  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    inputData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F4F8),
        appBar: cusAppbar(
          context: context,
          title: 'จัดการข้อมูลวิสาหกิจชุมชน',
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('visa')
              .document(userID)
              .snapshots(),
          builder: (context, sn) {
            if (!sn.hasData) {
              return Text('Loading data Please wait...');
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 12.0),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 75.0,
                        child: CircleAvatar(
                          radius: 70.0,
                          backgroundColor: Color(0XFFFFFFFF),
                          backgroundImage: NetworkImage(sn.data['imgpro']),
                        ),
                      ),

                      SizedBox(height: 20.0),

                      _form(title: 'ชื่อวิสาหกิจ', content: sn.data['visaName']),

                      _form(title: 'เลขที่', content: sn.data['addrNo']),

                      _form(title: 'ถนน', content: sn.data['road']),

                      _form(title: 'ตำบล', content: sn.data['subDistrict']),

                      _form(title: 'อำเภอ', content: sn.data['district']),

                      _form(title: 'จังหวัด', content: sn.data['province']),

                      _form(title: 'รหัสไปรษณีย์', content: sn.data['zipCode']),

                      _form(title: 'เบอร์โทรศัพท์', content: sn.data['tel']),

                      _form(title: 'อีเมล', content: sn.data['email']),

                      SizedBox(height: 20.0),

                      cusBtn(
                        action: () => logout(context),
                        color: Colors.red,
                        text: 'ออกจากระบบ',
                      ),
                      SizedBox(height: 12.0),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _form({
  title,
  content,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black54,
          ),
        ),
        Divider(
          thickness: 2,
          color: Colors.black45,
        ),
      ],
    ),
  );
}
