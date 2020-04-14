import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/utils/request.dart';
import 'package:ai_reader/utils/api.dart';

class BInfoPage extends StatefulWidget {
  final String bookId;
  BInfoPage({Key key, this.bookId}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BInfoPageState(bookId: this.bookId);
  }
}

class BInfoPageState extends State<BInfoPage> {

  String bookId;
  var bookInfo;

  BInfoPageState({
    Key key,
    this.bookId
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(bookInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('书籍详情'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('书籍详情'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    child: CachedNetworkImage(imageUrl: 'http://statics.zhuishushenqi.com' + bookInfo['cover'], width: 60, height: 80,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(bookInfo['title'], textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0, height: 1.4),),
                        Row(
                          children: <Widget>[
                            Text(bookInfo['author'], textAlign: TextAlign.left, style: TextStyle(fontSize: 12.0, height: 1.4, color: Colors.red),),
                            Text('   |   ', style: TextStyle(fontSize: 14.0, height: 1.4, color: Colors.black26),),
                            Text(bookInfo['minorCate'], textAlign: TextAlign.left, style: TextStyle(fontSize: 12.0, height: 1.4, color: Colors.black54),),
                            Text('   |   ', style: TextStyle(fontSize: 14.0, height: 1.4, color: Colors.black26),),
                            Text(bookInfo['wordCount'].toString() + '字', textAlign: TextAlign.left, style: TextStyle(fontSize: 12.0, height: 1.4, color: Colors.black54),),
                          ],
                        ),
                        Text(bookInfo['lastChapter'], textAlign: TextAlign.left, style: TextStyle(fontSize: 12.0, height: 1.4, color: Colors.black54),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            new Divider(),
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 30.0,
                    padding: EdgeInsets.only(right: 15.0),
                    child: RaisedButton(
                      onPressed: () {

                      },
                      color: Theme.of(context).primaryColor,
                      child: Text('加入书架'),
                      textTheme: ButtonTextTheme.primary,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 30.0,
                    padding: EdgeInsets.only(left: 15.0),
                    child: RaisedButton(
                      onPressed: () {
                        Routes.router.navigateTo(context, '/book/read/' + bookInfo['_id']);
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text('开始阅读'),
                      textTheme: ButtonTextTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            new Divider(),
            Container(
              child: new ChipTheme(
                data: Theme.of(context).chipTheme,
                child: Wrap(
                  spacing: 8.0,
                  children: _buildGridTileList(),
                )
              ),
            ),
            new Divider(),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              child: Text.rich(
                TextSpan(children: [TextSpan(text: bookInfo['longIntro'],)]),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              color: const Color(0xffe9eaec),
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGridTileList() {
    List<Widget> widgetList = new List();
    for (int i = 0; i < bookInfo['tags'].length; i++) {
      widgetList.add(Chip(
//        backgroundColor: const Color(0xffff5722),
        key: ValueKey<String>(bookInfo['tags'][i]),
        label: Text(bookInfo['tags'][i],),
        labelStyle: TextStyle(color: Colors.white),
      ));
    }
    return widgetList;
  }

  getBookInfo() {
    String url = Api.host + Api.bookInfo + bookId;

    Request.get(url).then((res) {
      if(res != null){
        setState(() {
          bookInfo = res;
        });
      }
    });
  }

}

