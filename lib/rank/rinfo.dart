import 'package:flutter/material.dart';
import 'package:ai_reader/components/rank_book_list.dart';
import 'dart:convert';

import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/utils/request.dart';
import 'package:ai_reader/utils/api.dart';

class RInfoPage extends StatefulWidget {
  RInfoPage({Key key, this.rankInfo}):super(key: key);
  String rankInfo;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RInfoPageState(rankInfo: this.rankInfo);
  }
}

class RInfoPageState extends State<RInfoPage> {
  String rankInfo;
  RInfoPageState({Key key, this.rankInfo});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var rank = json.decode(rankInfo);
    if (rank['monthRank'] == null || rank['totalRank'] == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(rank['title']),
        ),
        body: RankBookList(rankId: rank['_id'],),
      );
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(rank['title']),
          bottom: new TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              new Tab(text: '周榜',),
              new Tab(text: '月榜',),
              new Tab(text: '总榜',),
            ],
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            RankBookList(rankId: rank['_id'],),
            RankBookList(rankId: rank['monthRank'],),
            RankBookList(rankId: rank['totalRank'],),
          ],
        ),
      ),
    );
  }

}
