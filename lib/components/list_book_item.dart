import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ai_reader/utils/route.dart';

class ListBookItem extends StatelessWidget {

  // 书名
  final String id;
  // 书名
  final String name;
  // 作者
  final String author;
  // 封面
  final String cover;
  // 简介
  final String shortIntro;
  // 主分类
  final String majorCate;
  // 二级分类
  final String minorCate;
  // 追书人数
  final String latelyFollower;
  // 读者留存率
  final String retentionRatio;

  ListBookItem({
    Key key,
    this.id,
    this.name,
    this.author,
    this.cover,
    this.shortIntro,
    this.majorCate,
    this.minorCate,
    this.latelyFollower,
    this.retentionRatio,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return ListTile(
//      leading: CachedNetworkImage(imageUrl: 'http://statics.zhuishushenqi.com' + cover),
//      title: Text(name),
//      subtitle: Text(author),
//    );
    return GestureDetector(
      onTap: () {
        Routes.router.navigateTo(context, '/book/info/${id}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0, bottom: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              padding: EdgeInsets.all(10.0),
              child: CachedNetworkImage(imageUrl: 'http://statics.zhuishushenqi.com' + cover, width: 60, height: 80,),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
                  Text(author, textAlign: TextAlign.left, style: TextStyle(fontSize: 14.0, color: Colors.black26),),
                  Text(shortIntro, textAlign: TextAlign.left, maxLines: 2, style: TextStyle(fontSize: 12.0, color: Colors.black26),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('追书人数：', style: TextStyle(fontSize: 12.0,height: 1.5),),
                      Text(latelyFollower, style: TextStyle(fontSize: 13.0, color: Colors.pink,height: 1.5),),
                      Text('读者留存率：', style: TextStyle(fontSize: 12.0,height: 1.5)),
                      Text(retentionRatio, style: TextStyle(fontSize: 13.0, color: Colors.pink,height: 1.5),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}