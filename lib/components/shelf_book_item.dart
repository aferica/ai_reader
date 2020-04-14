import 'package:flutter/material.dart';
import 'package:aferica_flutter_components/my_image/index.dart';

import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/db/shelf.dart';

class ShelfBookItem extends StatelessWidget {

  final Shelf shelf;

  /// 点击事件
  final VoidCallback onTap;
  /// 点击事件
  final VoidCallback onLongPress;

  ShelfBookItem({
    Key key,
    this.shelf,
    this.onTap,
    this.onLongPress
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0, bottom: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 95,
              padding: EdgeInsets.only(right: 20.0),
              child: MyNetWorkImage(src: shelf.cover, width: 60, height: 80,),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(shelf.name, textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0), maxLines: 1,),
                  Text(shelf.author, textAlign: TextAlign.left, style: TextStyle(fontSize: 14.0, color: Colors.black26),),
                  Text(shelf.currentChapter, textAlign: TextAlign.left, maxLines: 2, style: TextStyle(fontSize: 12.0, color: Colors.black26),),
                  Text(shelf.newChapter, textAlign: TextAlign.left, maxLines: 2, style: TextStyle(fontSize: 12.0, color: Colors.black26),),
                ],
              ),
            ),
            Container(
              height: 20,
              padding: EdgeInsets.only(left: 1.0, right: 1.0),
              decoration: new BoxDecoration(
                color: Theme.of(context).cursorColor,
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              ),
              child: Center(
                child: Text((shelf.chapterCount - shelf.currentChapterNum).toString(),
                  style: Theme.of(context).accentTextTheme.body2.copyWith(fontSize: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}