import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gbk2utf8/gbk2utf8.dart';

final Dio dio = new Dio();

class Request {
  static Future<Map<String, dynamic>> get(String url) async {
    Response res = await dio.get(url);
    if (res.data.toString() == 'false') {
      return null;
    }
    String tempRes = res.data.toString();
    if(tempRes[0] == '[') {
      tempRes = '{"reslut":' + tempRes + '}';
    }
    Map<String, dynamic> result = json.decode(tempRes);
    print(result);
    return result;
  }


  static Future<String> getFromHtml(String url, { Map<String, String> params }) async {
    Response res = await dio.put(url);

    String html = gbk.decode(res.data);
    print(html);

    return html;
  }
}