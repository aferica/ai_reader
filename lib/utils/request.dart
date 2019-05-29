import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'route.dart';

final Dio dio = new Dio();
//final context = BuildContext;

class Request {

  static Future<Map<String, dynamic>> get(String url, { Map<String, String> params }) async {
    print(url);
    Map<String, dynamic> result = new Map();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('token') ?? '';
//    if(token == '') {
//      Fluttertoast.showToast(msg: '请登录后使用', backgroundColor: Colors.black54, fontSize: 14.0);
////      Routes.router.navigateTo(context, '${Routes.login}');
//    } else {
      Response res = await dio.get(
        url,
        queryParameters: params,
//        options: new Options(headers: { 'Authorization': 'Bearer ' + token })
      );
      result = json.decode(res.toString());
      print(result);
//      if (!result['ok']) {
//        Fluttertoast.showToast(msg: result['msg'], backgroundColor: Colors.black54, fontSize: 14.0);
//        result = null;
//      }
//    }

    return result;
  }

  static Future<Map<String, dynamic>> post(String url, { Map<String, String> params }) async {
    Map<String, dynamic> result = new Map();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('token') ?? '';
//    Options options = new Options();
//    if(token != '') {
//      options.headers = { 'Authorization': 'Bearer ' + token };
//    }
    Response res = await dio.post(
        url,
        data: params,
//        options: options
    );
    print(res);
    result = json.decode(res.toString());
//    if (result['ok']) {
//      Fluttertoast.showToast(msg: result['msg'], backgroundColor: Colors.black54, fontSize: 14.0);
//      result = null;
//    }

    return result;
  }

  static Future<Map<String, dynamic>> put(String url, { Map<String, String> params }) async {
    Map<String, dynamic> result = new Map();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('token') ?? '';
//    Options options = new Options();
//    if(token != '') {
//      options.headers = { 'Authorization': 'Bearer ' + token };
//    }
    Response res = await dio.put(
        url,
        data: params,
//        options: options
    );
    result = json.decode(res.toString());
//    if (result['ok']) {
//      Fluttertoast.showToast(msg: result['msg'], backgroundColor: Colors.black54, fontSize: 14.0);
//      result = null;
//    }

    return result;
  }
}