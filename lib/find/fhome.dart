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
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset('static/images/zhuishu.png', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('追书神器'),
            trailing: Icon(Icons.chevron_right,),
            onTap: (){
              Routes.router.navigateTo(context, Routes.rList);
            },
          ),
          new Divider(height: 0,),
          ListTile(
//            title: Image.asset('static/images/qidian.png', width: width / 3 * 2, height: 50,),
            leading: Image.asset('static/images/qidian.png', width: 30.0, height: 40.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('起点'),
            trailing: Icon(Icons.chevron_right,),
          ),
          new Divider(height: 0,),
          ListTile(
//            title: Image.asset('static/images/zongheng.png', width: width / 3 *  1, height: 40,),
            leading: Image.asset('static/images/zongheng.png', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('纵横'),
            trailing: Icon(Icons.chevron_right,),
          ),
          new Divider(height: 0,),
          ListTile(
//            title: Image.asset('static/images/17k.png', width: width / 3 * 2, height: 60,),
            leading: Image.asset('static/images/17k.png', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('17K'),
            trailing: Icon(Icons.chevron_right,),
          ),
          new Divider(height: 0,),
          ListTile(
//            title: Image.asset('static/images/jinjiang.jpg', width: width / 3 * 2, height: 60,),
            leading: Image.asset('static/images/jinjiang.jpg', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('晋江'),
            trailing: Icon(Icons.chevron_right,),
          ),
          new Divider(height: 0,),
          ListTile(
//            title: Image.asset('static/images/jinjiang.jpg', width: width / 3 * 2, height: 60,),
            leading: Image.asset('static/images/biquge.jpg', width: 30.0, height: 30.0,),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            title: Text('笔趣阁'),
            trailing: Icon(Icons.chevron_right,),
          ),
        ],
      ),
    );
  }
}
