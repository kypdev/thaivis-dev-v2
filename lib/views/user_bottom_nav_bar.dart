import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thaivis_dev_v2/views/users/destination.dart';
import 'package:thaivis_dev_v2/views/users/user_history.dart';
import 'package:thaivis_dev_v2/views/users/user_home_page.dart';
import 'package:thaivis_dev_v2/views/users/user_profile.dart';

class ViewNavigatorObserver extends NavigatorObserver {
  final VoidCallback onNavigation;
  ViewNavigatorObserver(this.onNavigation);
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }

  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }
}

class BottomNavBarView extends StatefulWidget {
  final Destination destination;
  final VoidCallback onNavigation;

  const BottomNavBarView({Key key, this.destination, this.onNavigation})
      : super(key: key);

  @override
  _BottomNavBarViewState createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation),
      ],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return UserHomePage(
                    destination: widget.destination,
                  );
                case '/profile':
                  return UserProfile(
                    destination: widget.destination,
                  );
                case '/history':
                  return UserHistory(
                    destination: widget.destination,
                  );
              }
            });
      },
    );
  }
}

class UserBottomNavHome extends StatefulWidget {
  @override
  _UserBottomNavHomeState createState() => _UserBottomNavHomeState();
}

class _UserBottomNavHomeState extends State<UserBottomNavHome>
    with TickerProviderStateMixin {
  List<Key> _destinationKeys;
  List<AnimationController> _faders;
  AnimationController _hide;
  int _currentIndex = 0;
  final List<Widget> _children = [
    UserHomePage(),
    UserProfile(),
    UserHistory()
  ];

  @override
  void initState() {
    super.initState();

    _faders =
        allDestinations.map<AnimationController>((Destination destination) {
      return AnimationController(
          vsync: this, duration: Duration(milliseconds: 200));
    }).toList();
    _faders[_currentIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(allDestinations.length, (int index) => GlobalKey())
            .toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            _hide.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          items: [
         new BottomNavigationBarItem(
           icon: Icon(Icons.home),
           title: Text('วิสาหกิจชุมชน'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('ข้อมูลส่วนตัว'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.history),
           title: Text('ประวัติ')
         )
       ],
        ),
      ),
    );

    // NotificationListener<ScrollNotification>(
    //   onNotification: _handleScrollNotification,
    //   child: Scaffold(
    //     body: SafeArea(
    //       top: false,
    //       child: Stack(
    //         fit: StackFit.expand,
    //         children: allDestinations.map((Destination destination) {
    //           final Widget view = FadeTransition(
    //             opacity: _faders[destination.index].drive(CurveTween(curve: Curves.fastOutSlowIn)),
    //             child: BottomNavBarView(
    //               destination: destination,
    //               onNavigation: () {
    //                 _hide.forward();
    //               },
    //             ),
    //           );
    //           if (destination == _currentIndex) {
    //             _faders[destination.index].forward();
    //             return view;
    //           }else {
    //             _faders[destination.index].reverse();
    //             if(_faders[destination.index].isAnimating){
    //               return IgnorePointer(child: view);
    //             }
    //             return Offstage(child: view);
    //           }
    //         }).toList(),
    //       ),
    //     ),
    //     bottomNavigationBar: ClipRect(
    //       child: SizeTransition(
    //         sizeFactor: _hide,
    //         axisAlignment: -1.0,
    //         child: BottomNavigationBar(
    //           currentIndex: _currentIndex,
    //           onTap: (int index) {
    //             setState(() {
    //               _currentIndex = index;
    //             });
    //           },
    //           items: allDestinations.map((Destination destination) {
    //             return BottomNavigationBarItem(
    //               icon: Icon(destination.icon),
    //               backgroundColor: destination.color,
    //               title: Text(destination.title)
    //             );
    //           }).toList(),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
