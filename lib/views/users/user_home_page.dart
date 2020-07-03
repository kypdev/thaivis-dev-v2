import 'package:flutter/material.dart';
import 'package:thaivis_dev_v2/views/users/category.dart';
import 'package:thaivis_dev_v2/views/users/destination.dart';
import 'package:thaivis_dev_v2/views/users/near_province.dart';
import 'package:thaivis_dev_v2/views/users/new_price.dart';
import 'package:thaivis_dev_v2/views/users/province.dart';

class UserHomePage extends StatefulWidget {
  final Destination destination;

  const UserHomePage({Key key, this.destination}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'วิสาหกิจชุมชน (บุคคลทั่วไป)',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            tabs: [
              new Tab(
                icon: new Icon(Icons.star),
                text: 'สินค้าใหม่',
              ),
              new Tab(
                icon: new Icon(Icons.local_activity),
                text: 'พื้นที่ใกล้เคียง',
              ),
              new Tab(
                icon: new Icon(Icons.assessment),
                text: 'จังหวัด',
              ),
              new Tab(
                icon: new Icon(Icons.list),
                text: 'หมวดหมู่',
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1.0,
        ),
        body: TabBarView(
          children: [
            NewPrice(),
            NearProvince(),
            Province(),
            Category()
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
