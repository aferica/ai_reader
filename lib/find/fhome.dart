import 'package:flutter/material.dart';

import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/utils/request.dart';
import 'package:ai_reader/utils/api.dart';

class FHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FHomePageState();
  }
}

class FHomePageState extends State<FHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset('static/images/home_find_rank.png', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('排行榜'),
            trailing: Icon(Icons.chevron_right,),
            onTap: (){
              Routes.router.navigateTo(context, Routes.rList);
            },
          ),
          new Divider(height: 0,),
          ListTile(
            leading: Image.asset('static/images/home_find_topic.png', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('主题'),
            trailing: Icon(Icons.chevron_right,),
          ),
          new Divider(height: 0,),
          ListTile(
            leading: Image.asset('static/images/home_find_category.png', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('分类'),
            trailing: Icon(Icons.chevron_right,),
          ),
        ],
      ),
    );
  }
}
