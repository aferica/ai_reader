import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';
//
//import 'utils/route.dart';
//import 'utils/request.dart';
//import 'utils/api.dart';

import 'package:ai_reader/books/shelf.dart';
import 'package:ai_reader/find/fhome.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> userInfo;

  PageController pageController;
  TabController _tabController;
  int page = 0;
  List titles = ['书架', '发现'];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('免费小说阅读'),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white,),
              onPressed: null
            ),
            IconButton(
              icon: Icon(IconData(0xe607, fontFamily: 'aliIconFont'), color: Theme.of(context).primaryIconTheme.color,),
              onPressed: null,
            ),
          ],
          bottom: new TabBar(
            tabs: <Widget>[
              new Tab(text: '书架',),
//              new Tab(text: '社区',),
              new Tab(text: '发现',),
//              new Tab(icon: new Icon(Icons.directions_bus),),
            ],
            controller: _tabController,
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
            ],
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new BookShelfPage(),
//            new FHomePage(),
            new FHomePage(),
//            new FHomePage(),
          ],
        ),
      ),
//        new JHomePage(),
//      new PageView(
//        physics: NeverScrollableScrollPhysics(),
//        children: <Widget>[
//          new BookShelfPage(),
//          new FHomePage(),
//        ],
//        controller: pageController,
//        onPageChanged: pageChanged,
//      ),
//      // This trailing comma makes auto-formatting nicer for build methods.
//      bottomNavigationBar: CupertinoTabBar(
//        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(IconData(0xe70b, fontFamily: 'aliIconFont'), size: 28.0,),
//            activeIcon: Icon(IconData(0xe710, fontFamily: 'aliIconFont'), size: 28.0,),
//            title: Text('书架'),
//            backgroundColor: Theme.of(context).primaryColor
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(IconData(0xe70a, fontFamily: 'aliIconFont'), size: 28.0,),
//            activeIcon: Icon(IconData(0xe70f, fontFamily: 'aliIconFont'), size: 28.0,),
//            title: Text('发现'),
//            backgroundColor: Theme.of(context).primaryColor
//          ),
//        ],
//        onTap: changeTabBar,
//        currentIndex: page,
//      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    checkLogin();
    pageController = new PageController(initialPage: page);
  }

//  checkLogin() async{
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    String token = preferences.getString('token') ?? '';
//    if(token == '') {
//      Routes.router.navigateTo(context, '${Routes.login}', clearStack: true);
//    } else {
//      Request.get(Api.host + Api.check).then((res) {
//        print(res);
//        if (res == null) {
//          Routes.router.navigateTo(context, '${Routes.login}', clearStack: true);
//        } else {
//          print(preferences.getString('userInfo'));
//          setState(() {
//            userInfo = json.decode(preferences.getString('userInfo'));
//          });
//        }
//      });
//    }
//  }

  void changeTabBar(int index) {
    pageController.jumpToPage(index);
  }

  void pageChanged(int pageIndex) {
    setState(() {
      page = pageIndex;
    });
  }
}
