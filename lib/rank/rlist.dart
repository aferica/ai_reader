import 'package:flutter/material.dart';

import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/utils/request.dart';
import 'package:ai_reader/utils/api.dart';

class RListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RListPageState();
  }
}

class RListPageState extends State<RListPage> {

  var rankList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getRankList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('排行榜'),
          bottom: new TabBar(
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              new Tab(text: '男生',),
              new Tab(text: '女生',),
            ],
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            _buildRankList('male'),
            _buildRankList('female'),
          ],
        ),
      ),
    );
  }

  Widget _buildRankList(String key) {
    if(rankList == null) {
      return new Center(
//        child: CircularProgressIndicator(),
      );
    }
    List rankData = rankList[key];
    List importantRank = [];
    List notImportantRank = [];
    for(int i = 0; i < rankData.length; i++){
      var item = rankData[i];
      if(!item['collapse']) {
        importantRank.add(item);
      } else {
        notImportantRank.add(item);
      }
    }
    importantRank.add(null);
    return  // Column(
//      children: <Widget>[
        ListView.builder(
          itemCount: importantRank.length,
          itemBuilder: (BuildContext context, int index) {
            if(index < importantRank.length - 1) {
              var item = importantRank[index];
              return ListTile(
                leading: Image.network('http://statics.zhuishushenqi.com' + item['cover'], height: 28, width: 28,),
                title: Text(item['title']),
                onTap: () {
                  String bodyJson = '';
                  if(item['monthRank']!=null && item['totalRank']!=null) {
                    bodyJson = '{"title":"${item['title']}","_id":"${item['_id']}","monthRank":"${item['monthRank']}","totalRank":"${item['totalRank']}"}';
                  } else {
                    bodyJson = '{"title":"${item['title']}","_id":"${item['_id']}"}';
                  }
                  Routes.router.navigateTo(context, '/rank/info/' + bodyJson);
                },
              );
            }
            if(index == importantRank.length - 1) {
              return ExpansionTile(
                title: const Text('别人家的排行榜'),
                leading: Image.asset('static/images/ic_rank_collapse.png', height: 28, width: 28,),
                children: _buildOtherList(notImportantRank),
              );
            }
            return null;
          },
//          separatorBuilder: (BuildContext context, int index) => new Divider(height: 0,),
//        ),
//      ],
    );
  }

  List<Widget> _buildOtherList(List listData) {
    List<Widget> otherList = [];
    for(int i = 0; i < listData.length; i++) {
      var item = listData[i];
      otherList.add(ListTile(
        title: Text(item['title']),
        onTap: () {
          String bodyJson = '{"title":"${item['title']}","_id":"${item['_id']}"}';
          Routes.router.navigateTo(context, '/rank/info/' + bodyJson);
        },
      ));
    }
    return otherList;
  }

  getRankList() {
    String url = Api.host + Api.rankList;

    Request.get(url).then((res) {
      if(res != null && res['ok'] == true){
        setState(() {
          rankList = res;
        });
      }
    });
  }
}
