import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/common/cus_btn.dart';
import 'package:thaivis_dev_v2/services/auth.dart';
import 'package:thaivis_dev_v2/views/users/destination.dart';

class UserProfile extends StatefulWidget {
  final Destination destination;

  const UserProfile({Key key, this.destination}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Auth auth = new Auth();
  String userID;

  void debugButton() {
    print('userid: $userID');
  }

  void logout() {
    auth.signOut(context);
  }

  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  @override
  void initState() {
    inputData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ข้อมูลส่วนตัว',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.person,
                ),
                onPressed: debugButton),
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(userID)
              .snapshots(),
          builder: (context, sn) {
            if (!sn.hasData) {
              return Text('Loading data Please wait...');
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                    // Text(sn.data['firstname']),
                    // Text(sn.data['lastname']),
                    // Text(sn.data['email']),

                    _form(
                      title: 'ชื่อ',
                      content: sn.data['firstname']
                    ),

                    _form(
                      title: 'นามสกุล',
                      content: sn.data['lastname']
                    ),

                    _form(
                      title: 'อีเมล',
                      content: sn.data['email']
                    ),
                    
                    SizedBox(height: 20.0),
                    cusBtn(
                      action: () => logout(),
                      color: Colors.red,
                      text: 'ออกจากระบบ',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// cusBtn(
//                 action: ()=> debugButton(),
//                 color: Colors.green,
//                 text: 'debug',
//               ),

//               SizedBox(height: 20.0),

//               cusBtn(
//                 action: () => logout(),
//                 color: Colors.red,
//                 text: 'ออกจากระบบ',
//               ),


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
