import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'package:ai_reader/utils/shared_pres.dart';

import 'theme.dart';
import 'theme1.dart';
import 'theme2.dart';
//import 'theme3.dart';
import 'theme4.dart';

class ThemePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ThemePageState();
}

class MyTheme {
  String name;
  String value;
  ThemeData theme;

  MyTheme(this.name, this.value, this.theme);
}

List<MyTheme> myThemeList = [
  new MyTheme("主题1--蓝色", 'blue', myBlueTheme),
  new MyTheme("主题2--黄色", 'orange', myOrangeTheme),
  new MyTheme("主题3--绿色", 'green', myGreenTheme),
//  new MyTheme("主题4--黑色", 'black', myDarkTheme),
  new MyTheme("主题4--茶色", 'teal', myTealTheme),
];


class ThemePageState extends State<ThemePage> {

  var listData;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('选择主题'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () async{
              bool isDark = Theme.of(context).brightness == Brightness.dark;
              await DynamicTheme.of(context).setBrightness(isDark ? Brightness.light: Brightness.dark);
              await SharedPres.setBool('selectThemeIsDark', !isDark);
            },
          )
        ],
      ),
      body: ListView(
        children: _buildThemeList(),
      ),
    );
  }

  List<Widget> _buildThemeList() {
    List<Widget> lists = new List();
    for(MyTheme theme in myThemeList) {
      lists.add(new ListTile(
        title: new Text(theme.name, maxLines: 1,),
        leading: CircleAvatar(child: Text('', style: TextStyle(fontSize: 12),), backgroundColor: theme.theme.primaryColor,),
        onTap: () async {
          DynamicTheme.of(context).setThemeData(theme.theme);
          await SharedPres.set('selectThemeName', theme.value);
          Navigator.of(context).pop();
        },
      ));
    }

    return lists;
  }

}