import 'package:fluro/fluro.dart';

import 'package:ai_reader/home.dart';
import 'package:ai_reader/books/shelf.dart';
import 'package:ai_reader/books/read.dart';
import 'package:ai_reader/books/info.dart';

import 'package:ai_reader/rank/rlist.dart';
import 'package:ai_reader/rank/rinfo.dart';

class Routes {
  static Router router;
  static String home = '/';
  static String bShelf = '/book/shelf';
  static String bRead = '/book/read/:id';
  static String bInfo = '/book/info/:id';

  static String rList = '/rank/list';
  static String rInfo = '/rank/info/:id';


  static void configureRoutes(Router router) {
    router.define(
        home,
        handler: Handler(handlerFunc: (context, params) => MyHomePage()),
        transitionType: TransitionType.inFromRight
    );
    router.define(
        bShelf,
        handler: Handler(handlerFunc: (context, params) => BookShelfPage()),
        transitionType: TransitionType.inFromRight
    );
    router.define(
        bRead,
        handler: Handler(handlerFunc: (context, params) {
          return BReadPage(bookId: params['id'][0]);
        }),
        transitionType: TransitionType.inFromRight
    );
    router.define(
        bInfo,
        handler: Handler(handlerFunc: (context, params) {
          return BInfoPage(bookId: params['id'][0],);
        }),
        transitionType: TransitionType.inFromRight
    );
    router.define(
        rList,
        handler: Handler(handlerFunc: (context, params) => RListPage()),
        transitionType: TransitionType.inFromRight
    );
    router.define(
        rInfo,
        handler: Handler(handlerFunc: (context, params) {
          return RInfoPage(rankInfo: params['id'][0],);
        }),
        transitionType: TransitionType.inFromRight
    );
//    router.define(
//        jCollection,
//        handler: Handler(handlerFunc: (context, params) {
//          print(params);
//          Map<String, dynamic> map = json.decode(params['data'][0]);
//          return CollectionsPage(type: map['type'], title: map['title'],);
//        }),
//        transitionType: TransitionType.inFromRight
//    );


    Routes.router = router;
  }
}