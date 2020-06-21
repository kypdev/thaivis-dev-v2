import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:thaivis_dev_v2/models/users.dart';

final String url = '192.168.130.251';

Future<String> registerService(
  String fname,
  String lname,
  String email,
  String passwords,
  String type,
) async {
  Users members = Users(
      firstname: fname,
      lastname: lname,
      email: email,
      passwords: passwords,
      type: type);

  final res = await http.post(
    Uri.encodeFull('http://$url/api/user/signup.php'),
    body: json.encode(members.toJson()),
    headers: {"Content-Type": "application/json"},
  );

  if (res.statusCode == 200) {
    final resData = await json.decode(res.body);
    return resData['status'];
  } else {
    return null;
  }
}
