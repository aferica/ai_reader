import 'package:fluro/fluro.dart';
import 'dart:convert';

import 'package:ai_reader/home.dart';
import 'package:ai_reader/books/shelf.dart';

class Routes {
  static Router router;
  static String home = '/';
  static String bShelf = '/book/shelf';

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