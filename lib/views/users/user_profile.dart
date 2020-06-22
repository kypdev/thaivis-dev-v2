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

  void logout() {
    auth.signOut(context);
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
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://firebasestorage.googleapis.com/v0/b/thaivis-88ffb.appspot.com/o/%E0%B8%B5userprofile%2Fimage_picker8565803787862496061.jpg?alt=media&token=1d32e401-a4cf-4e1d-97c8-34babef92460'),
            cusBtn(
              action: () => logout(),
              color: Colors.red,
              text: 'ออกจากระบบ',
            ),
          ],
        ),
      ),
    );
  }
}
