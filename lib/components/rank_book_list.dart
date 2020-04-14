import 'package:flutter/material.dart';
import 'package:ai_reader/components/list_book_item.dart';

//import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/utils/request.dart';
import 'package:ai_reader/utils/api.dart';

class RankBookList extends StatefulWidget {
  RankBookList({Key key, this.rankId}):super(key: key);
  final String rankId;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RankBookListState(rankId: this.rankId);
  }
}

class RankBookListState extends State<RankBookList> {

  final String rankId;

  var rankInfo;

  RankBookListState({
    Key key,
    this.rankId,
  });


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRankInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(rankInfo == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
        itemExtent: 120,
        itemCount: rankInfo['ranking']['books'].length,
        itemBuilder: (BuildContext _content, int i) {
          if (i < rankInfo['ranking']['books'].length) {
            var book = rankInfo['ranking']['books'][i];
            return ListBookItem(
              id: book['_id'],
              name: book['title'],
              author: book['author'],
              cover: book['cover'],
              shortIntro: book['shortIntro'],
              minorCate: book['minorCate'],
              majorCate: book['majorCate'],
              latelyFollower: book['latelyFollower'].toString(),
              retentionRatio: book['retentionRatio'].toString(),
            );
          }
          return null;
        }
    );
  }


  getRankInfo() {
    String url = Api.host + Api.rankBookList + rankId;

    Request.get(url).then((res) {
      if(res != null && res['ok']){
        setState(() {
          rankInfo = res;
        });
      }
    });
  }
}