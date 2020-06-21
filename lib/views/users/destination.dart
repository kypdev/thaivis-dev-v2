import 'package:flutter/material.dart';

class Destination {
  final int index;
  const Destination(this.index, this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination(0, 'วิสาหกิจชุมชน', Icons.home, Colors.teal),
  Destination(1,'ข้อมูลส่วนตัว', Icons.person, Colors.cyan),
  Destination(2,'ประวัติ', Icons.school, Colors.orange)
];