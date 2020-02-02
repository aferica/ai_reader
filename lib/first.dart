import 'package:flutter/material.dart';

import 'package:ai_reader/utils/route.dart';

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('请选择性别', style: Theme.of(context).textTheme.title,),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(IconData(0xe648, fontFamily: 'aliIconFont'), size: MediaQuery.of(context).size.width / 3,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text('男生', style: Theme.of(context).textTheme.body2,),
                        Text('玄幻、都市、武侠', style: Theme.of(context).textTheme.body1,),
                      ],
                    ),
                  ),
//                  Container(
//                    width: MediaQuery.of(context).size.width / 3,
//                    child:  Center(
//                      child: Image.asset('static/images/ic_gender_logo.png')
//                    ),
//                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(IconData(0xe649, fontFamily: 'aliIconFont'), size: MediaQuery.of(context).size.width / 3, ),
//                        Image.asset('static/images/girl.png',
//                          height: MediaQuery.of(context).size.width / 3,
//                          width: MediaQuery.of(context).size.width / 3,
//                        ),
                        Text('女生', style: Theme.of(context).textTheme.body2,),
                        Text('耽美、言情、纯真', style: Theme.of(context).textTheme.body1,),
                      ],
                    ),

                  ),
                ],
              )
            ),
            MaterialButton(
//              color: Theme.of(context).primaryColor,
              child: Text('确定'),
              onPressed: (){
                goToHome();
              },
            ),
            GestureDetector(
              onTap: () {
                goToHome();
              },
              child: Text('跳过，稍后选择', style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontSize: Theme.of(context).textTheme.caption.fontSize,
                  height: 2
                )
              ),
            ),
//            Container(
//              height: MediaQuery.of(context).size.height / 6,
//              width: MediaQuery.of(context).size.width,
//              child: Center(
//                child: Text('跳过，稍后选择', style: Theme.of(context).textTheme.caption,),
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  goToHome() {
    Routes.router.navigateTo(context, '${Routes.home}', clearStack: true);
  }
}