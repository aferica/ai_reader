import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aferica_flutter_components/components/exception_message.dart';
import 'package:aferica_flutter_components/my_image/index.dart';

import 'package:ai_reader/components/shelf_book_item.dart';
import 'package:ai_reader/db/shelf.dart';
import 'package:ai_reader/utils/route.dart';

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

  List<Shelf> books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooksFromShelf();
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
            Shelf item = books[index];
            return ShelfBookItem(
              shelf: item,
              onTap: () {
                Routes.router.navigateTo(context, '/book/read/' + item.source);
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('确实删除《' + item.name + '》？'),
                      content: Text('删除后会删除本书的所有信息，包括历史和阅读记录，请注意！'),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text('确定删除'),
                          onPressed: () async {
                            await ShelfProvider().delete(item.id);
                            await getBooksFromShelf();
                            Navigator.of(context).pop();//关闭对话框
                          },
                        ),

                        new FlatButton(
                          child: new Text('再想一想'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                );
              },
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

  Future<void> _onRefresh() async {
    print('开始刷新');
    final Completer<void> completer = Completer<void>();
    await getBooksFromShelf();
    completer.complete();
    print('结束刷新');
    return null;
  }

  getBooksFromShelf() async {
    print('获取列表数据');
    List<Shelf> all = await ShelfProvider().getAll();
    setState(() {
      books = all;
    });
  }
}