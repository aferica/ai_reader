import 'dart:async';
import 'package:dio/dio.dart';

final Dio dio = new Dio();

class Request {
  static Future<Map<String, dynamic>> get(String url) async {
    Response res = await dio.get(url);
    if (res.data.toString() == 'false') {
      return null;
    }
    return res.data;
  }

  static Future<Map<String, dynamic>> post(String url, { Map<String, String> params }) async {
    Response res = await dio.post(
      url,
      data: params,
    );
    if (res.data.toString() == 'false') {
      return null;
    }

    return res.data;
  }

  static Future<Map<String, dynamic>> put(String url, { Map<String, String> params }) async {
    Response res = await dio.put(
      url,
      data: params,
    );

    return res.data;
  }

//  static Future<Map<String, dynamic>> get(String url, { Map<String, String> params }) async {
//    print(url);
//    Map<String, dynamic> result = new Map();
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String token = prefs.getString('token') ?? '';
////    if(token == '') {
////        showToast('请登录后使用');
////      Fluttertoast.showToast(msg: '请登录后使用', backgroundColor: Colors.black54, fontSize: 14.0);
//////      Routes.router.navigateTo(context, '${Routes.login}');
////    } else {
//      try {
//        Response res = await dio.get(
//            url,
//            queryParameters: params,
//            options: new Options(
//                responseType: ResponseType.plain
//            )
////        options: new Options(headers: { 'Authorization': 'Bearer ' + token })
//        );
//
//        String tempRes = res.toString();
//        if(tempRes[0] == '[') {
//          tempRes = '{"reslut":' + tempRes + '}';
//        }
//        result = json.decode(tempRes.toString());
//        print(result);
//      } catch (e) {
//        result = null;
//        showToast('网络请求错误，请重试');
//      }
////      if (!result['ok']) {
////        Fluttertoast.showToast(msg: result['msg'], backgroundColor: Colors.black54, fontSize: 14.0);
////        result = null;
////      }
////    }
//
//    return result;
//  }
//
//  static Future<Map<String, dynamic>> post(String url, { Map<String, String> params }) async {
//    Map<String, dynamic> result = new Map();
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String token = prefs.getString('token') ?? '';
////    Options options = new Options();
////    if(token != '') {
////      options.headers = { 'Authorization': 'Bearer ' + token };
////    }
//    Response res = await dio.post(
//        url,
//        data: params,
////        options: options
//    );
//    print(res);
//    result = json.decode(res.toString());
////    if (result['ok']) {
////      Fluttertoast.showToast(msg: result['msg'], backgroundColor: Colors.black54, fontSize: 14.0);
////      result = null;
////    }
//
//    return result;
//  }
//
//  static Future<Map<String, dynamic>> put(String url, { Map<String, String> params }) async {
//    Map<String, dynamic> result = new Map();
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String token = prefs.getString('token') ?? '';
////    Options options = new Options();
////    if(token != '') {
////      options.headers = { 'Authorization': 'Bearer ' + token };
////    }
//    Response res = await dio.put(
//        url,
//        data: params,
////        options: options
//    );
//    result = json.decode(res.toString());
////    if (result['ok']) {
////      Fluttertoast.showToast(msg: result['msg'], backgroundColor: Colors.black54, fontSize: 14.0);
////      result = null;
////    }
//
//    return result;
//  }
}