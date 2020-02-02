import 'package:flutter/material.dart';
//import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'dart:async';

class BookShelfPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookShelfPageState();
  }
}

class BookShelfPageState extends State<BookShelfPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

  static final List<String> _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('111111');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 20,
        child: ListView.separated(
          padding: kMaterialListPadding,
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index) {
            final String item = _items[index];
            return ListTile(
//              dense: true,
              leading: CircleAvatar(child: Text(item)),
              title: Text('结婚就是给自由穿件棉衣 $item.'),
              onLongPress: () {

              },
              subtitle: const Text('结婚就是给自由穿件棉衣',),
              contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              trailing: CircleAvatar(
                radius: 10.0,
                backgroundColor: Theme.of(context).errorColor,
                child: Text('1', style: TextStyle(fontSize: 10.0),),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => new Divider(height: 0,),
        ),
      ),
    );
  }

  Future<void> _onRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: const Text('Refresh complete'),
        action: SnackBarAction(
          label: 'RETRY',
          onPressed: () {
            _refreshIndicatorKey.currentState.show();
          })
        ),
      );
    });
  }
}