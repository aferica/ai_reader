import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlay;
import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/utils/request.dart';
import 'package:ai_reader/utils/api.dart';
import 'package:ai_reader/utils/url_util.dart';

class BReadPage extends StatefulWidget {
  String bookId;
  BReadPage({Key key, this.bookId}):super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BReadPageState(bookId: this.bookId);
  }
}

class BReadPageState extends State<BReadPage> {
  BReadPageState({
    Key key,
    this.bookId
  });

  String chapterTitle = '';
  String content;
  List<String> contents;
  String bookId;
  int chapterNo = 0;
  int pageNo = 0;

  double fontHeight = 1.1;
  double fontSize = 20;
  double screenHeight;
  double screenWidth;
  int maxLines = 24;

  TextStyle titleStyle = TextStyle(fontSize: 14, height: 1.5);
  TextStyle contentStyle;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    SystemChrome.setEnabledSystemUIOverlays([]);
    getChapters();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    });

    contentStyle = TextStyle(
      fontSize: fontSize,
      height: fontHeight,
    );

    return Scaffold(
      backgroundColor: const Color(0xffE5D8AB),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: _buildContent()
        ),
      ),
    );
  }

  Widget _buildContent() {
    if(content != null && contents.length > 0) {
      print(contents[pageNo].substring(100));
      return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 30,
            child: Text(chapterTitle, style: titleStyle,),
          ),
          Positioned(
            top: 30,
            bottom: 30,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if(pageNo < contents.length - 1) {
                  setState(() {
                    pageNo = pageNo + 1;
                  });
                } else {
                  setState(() {
                    chapterNo = chapterNo + 1;
                    pageNo = 0;
                  });
                  getNextChapter();
                }
              },
              child: Text(
                contents[pageNo],
                style: contentStyle,
                maxLines: maxLines,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 30,
            child: Text(
              '第' + (pageNo + 1).toString() + '页 / 共' + contents.length.toString() + '页',
              style: titleStyle, textAlign: TextAlign.center,
            )
          )
        ],
      );
    } else {
      return new Center(
        child: CircularProgressIndicator(),
      );
    }
  }


  getChapters() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences = _sharedPreferences;
    });
    int readChapterNo = _sharedPreferences.getInt('readChapterNo_' + bookId) ?? 0;
    int readPageNo = _sharedPreferences.getInt('readPageNo_' + bookId) ?? 0;
    print(readChapterNo);
    if (_sharedPreferences.getString('chapters_' + bookId) != null && _sharedPreferences.getString('sources_' + bookId) != null ) {
      print(_sharedPreferences.getInt('selectSource_' + bookId));
      print(_sharedPreferences.getString('chapters_' + bookId));
      Map<String, dynamic> result = json.decode(_sharedPreferences.getString('chapters_' + bookId));
      print(result['chapters'][readChapterNo]['title']);
      getChapterContent(
          result['chapters'][readChapterNo]['link'] ?? '',
          result['chapters'][readChapterNo]['title'] ?? '',
          readChapterNo, readPageNo
      );
    } else {
      Request.get(Api.host + Api.bookSource + bookId).then((sources) {
        if (sources != null && sources.length > 0) {
          int selectSource = 0;
          if (sources['reslut'].length > 1) {
            selectSource = 1;
          }
          _sharedPreferences.setString('sources_' + bookId, json.encode(sources));
          _sharedPreferences.setInt('selectSource_' + bookId, selectSource);
          Request.get(Api.host + Api.bookChapters1 + sources['reslut'][selectSource]['_id'] + Api.bookChapters2).then((chapters) {
            if (chapters != null) {
              _sharedPreferences.setString('chapters_' + bookId, json.encode(chapters));
              getChapterContent(
                  chapters['chapters'][readChapterNo]['link'] ?? '',
                  chapters['chapters'][readChapterNo]['title'] ?? '',
                  readChapterNo, readPageNo
              );
            }
          });
        }
      });
    }
  }

  getNextChapter() {
    int readChapterNo = chapterNo;
    int readPageNo = 0;
    sharedPreferences.setInt('readChapterNo_' + bookId, readChapterNo);
    sharedPreferences.setInt('readPageNo_' + bookId, readPageNo);

    Map<String, dynamic> result = json.decode(sharedPreferences.getString('chapters_' + bookId));
    getChapterContent(
        result['chapters'][readChapterNo]['link'] ?? '',
        result['chapters'][readChapterNo]['title'] ?? '',
        readChapterNo, readPageNo
    );
  }

  getChapterContent(String link, String title, int readChapterNo, int readPageNo) {

    Request.get(Api.chapterHost + Api.bookContent + UrlEncode().encode(link)).then((res){
      String contentText = '你正在使用的版本已不再提供支持，为确保你的正常使用，请下载安装最新版<追书神器>。';
      if(res != null) {
        contentText = res['chapter']['cpContent'] ?? res['chapter']['body'] ?? res['body'];
        contentText = contentText.replaceAll(new RegExp(r'\n\n'), '\n');
        contentText = contentText.replaceAll(new RegExp(r'\n'), '\n\u3000\u3000');
      }
      contentText = '\u3000\u3000' + contentText;
      setState(() {
        chapterTitle = title;
        content = contentText;
        contents = pagingString(contentText);
        chapterNo = readChapterNo;
        pageNo = readPageNo;
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  List<String> pagingString(String text) {
    List<String> result = new List();
    int length = text.length;
    int tempLen = 0;
    while(tempLen < length) {
      String pageText = pageString(text.substring(tempLen));
      result.add(pageText);
      tempLen += pageText.length;
    }
    return result;
  }

  String pageString(String text) {
    if (hasOverflow(text)) {
      return text;
    }
    int maxLoop = 20;

    int start = 0;
    int end = text.length;
    int mid = (end + start) ~/ 2;

    // 最多循环20次
    for (int i = 0; i < maxLoop; i++) {
      if (hasOverflow(text.substring(0, mid))) {
        if (mid <= start || mid >= end) break;
        // 未越界
        start = mid;
        mid = (start + end) ~/ 2;
      } else {
        // 越界
        end = mid;
        mid = (start + end) ~/ 2;
      }
    }

    return text.substring(0, mid);
  }

  // 判断文本是否溢出
  bool hasOverflow(String text) {
    var tp = new TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          height: fontHeight,
        )
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: maxLines,
    );
    tp.layout(maxWidth: screenWidth, minWidth: screenWidth);

    return !(tp.didExceedMaxLines ||
        tp.height > (screenHeight - 180.0)
    );
  }

}

