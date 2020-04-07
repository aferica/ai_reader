import 'package:flutter/material.dart';
import 'package:aferica_flutter_components/components/exception_message.dart';

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

  List books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: buildShelf()
    );
  }

  Widget buildShelf() {
    if (books.length > 0) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 20,
        child: ListView.separated(
          padding: kMaterialListPadding,
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            final String item = books[index];
            return ListTile(
              leading: CircleAvatar(child: Text(item)),
              title: Text('Book'),
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
      );
    }

    return Center(
      child: ExceptionMessage(
        type: 'find',
        msg: '书架空空的',
        onClick: () {
          print('添加书籍');
        },
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