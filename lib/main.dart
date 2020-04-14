import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:oktoast/oktoast.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import 'theme/index.dart';
import 'utils/request.dart';
import 'utils/route.dart';
import 'utils/shared_pres.dart';
import 'package:ai_reader/db/db.dart';
import 'package:ai_reader/db/shelf.dart';

void main() async {
  final router = new Router();
  Routes.configureRoutes(router);
  Routes.router = router;
  // 添加dio拦截器
  dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        print('请求地址：' + options.uri.toString());
        options.responseType = ResponseType.plain;
//        /**
//         * 添加统一认证
//         */
//        String token = await SharedPres.get('token') ?? ''; // 这里token保存和获取可以使用SharedPreferences模块
//        if(token == '' && options.uri.toString() != Api.host + Api.login) {
//          // 处理未登录情况，如跳转到登录页
//          showToast('未登录或登录状态已过期，请登录后使用',);
//          // 结束请求 errMsg可以为任何类型，例如字符串、数字、Map等
//          return dio.resolve(null);
//        }
//        if(options.uri.toString() != Api.host + Api.login) {
//          // 使用jwt认证
//          options.headers['Authorization'] = 'Bearer ' + token;
//          // 或者添加token
//          options.headers['token'] = token;
//        }
        // continue
        return options;
      },
      onResponse: (Response response) async {
        // 对返回数据JSON数据处理
        // 例如`[{"":""},{"":""},{"":""}]`
        // 需要使用`{}`处理后才可以转为Map
        String tempRes = response.toString();
        print(tempRes);
        return response;
      },
      onError: (DioError e) {
        if(e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT || e.type == DioErrorType.SEND_TIMEOUT) {
          showToast('网络请求超时，请检查网络后重试');
        }
        if(e.type == DioErrorType.CANCEL) {
          showToast('用户取消请求');
        }
        return false;
      }
  ));
  runApp(MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  await ShelfProvider().open();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return OKToast(
          /// set toast style, optional
          position: ToastPosition.bottom,
          dismissOtherOnShow: true,
          textPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: MaterialApp(
            title: '免费小说阅读',
            //国际语言包
            localizationsDelegates:[GlobalMaterialLocalizations.delegate,GlobalWidgetsLocalizations.delegate],
            supportedLocales: [const Locale('zh', 'CH')],
            theme: theme,
            onGenerateRoute: Routes.router.generator,
            home: SplashScreen(),
          ),
        );
      }
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool loading = true;
  String loadingText = '加载中，请稍等...';

  String imageSrc = 'images/launch_image_1920.png';

  void navigationPage({bool isHome = false}) {
    Navigator.of(context).pop();
    if (isHome) {
      Routes.router.navigateTo(context, '${Routes.home}', clearStack: true);
    } else {
      Routes.router.navigateTo(context, '${Routes.first}', clearStack: true);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
//      checkPermission();
//      await FlutterDownloader.initialize();
//      await setTheme();
      showLoading();
      checkLogin();
    });
  }

  setTheme() async {
    String themeName = await SharedPres.get("selectThemeName") ?? '';
    bool isDark = await SharedPres.getBool("selectThemeIsDark") ?? false;
    ThemeData selectTheme = new ThemeData();
    for(MyTheme theme in myThemeList) {
      if (theme.value == themeName) {
        selectTheme = theme.theme;
      }
    }
    DynamicTheme.of(context).setThemeData(selectTheme);
    if (isDark) {
      DynamicTheme.of(context).setBrightness(Brightness.dark);
    }
  }

  checkLogin() async {
    String token = await SharedPres.get('token') ?? '';
    if (token == '') {
      navigationPage();
    }
  }

  showLoading() async {
//    showToastWidget(
//      Container(
//        height: 100,
//        width: 200,
//        child: Row(
//          children: <Widget>[
//            Container(
//              height: 100,
//              width: 90,
//              child: Center(
//                child: CircularProgressIndicator(),
//              ),
//            ),
//            Text(loadingText)
//          ],
//        ),
//      ),
//      position: ToastPosition.center
//    );
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 100,
            width: 200,
            child: Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Text(loadingText)
              ],
            ),
          ),
        )
    );
  }

//  // 申请权限
//  Future<bool> checkPermission() async {
//    // 先对所在平台进行判断
//    if (Theme.of(context).platform == TargetPlatform.android) {
//      PermissionStatus permission = await PermissionHandler()
//          .checkPermissionStatus(PermissionGroup.storage);
//      if (permission != PermissionStatus.granted) {
//        Map<PermissionGroup, PermissionStatus> permissions =
//        await PermissionHandler()
//            .requestPermissions([PermissionGroup.storage]);
//        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
//          return true;
//        }
//      } else {
//        return true;
//      }
//    } else {
//      return true;
//    }
//    return false;
//  }

  @override
  Widget build(BuildContext context) {
//    double height = MediaQuery.of(context).size.height;
//    double width = MediaQuery.of(context).size.width;
//    if (height / width > 2) {
//      imageSrc = 'images/launch_image_2340.png';
//    }

    return new Scaffold(
      body: new Center(
        child: Text('Home'),
//        child: new Image.asset(imageSrc,
//          height: height,
//          width: width,
//          fit: BoxFit.fitHeight,
//        ),
      ),
    );
  }
}

