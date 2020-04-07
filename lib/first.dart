import 'package:flutter/material.dart';
import 'package:aferica_flutter_components/components/blank_row.dart';

import 'package:ai_reader/utils/route.dart';
import 'package:ai_reader/utils/shared_pres.dart';

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPage> {

  int sex = 100;

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
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(IconData(0xe648, fontFamily: 'aliIconFont'), size: MediaQuery.of(context).size.width / 3,
                            color: sex == 0 ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          ),
                          Text('男生', style: Theme.of(context).textTheme.body2.copyWith(color: sex == 0 ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,),),
                          Text('玄幻、都市、武侠', style: Theme.of(context).textTheme.body1.copyWith(color: sex == 0 ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,),),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectSex(0);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(IconData(0xe649, fontFamily: 'aliIconFont'), size: MediaQuery.of(context).size.width / 3,
                            color: sex == 1 ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          ),
                          Text('女生', style: Theme.of(context).textTheme.body2.copyWith(color: sex == 1 ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,),),
                          Text('耽美、言情、纯真', style: Theme.of(context).textTheme.body1.copyWith(color: sex == 1 ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,),),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectSex(1);
                    },
                  ),
                ],
              )
            ),
            GestureDetector(
//              color: Theme.of(context).primaryColor,
              child: Text('确定', style: Theme.of(context).textTheme.title.copyWith(color: sex == 0 || sex == 1 ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,)),
              onTap: (){
                goToHome();
              },
            ),
            BlankRow(),
            BlankRow(),
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
          ],
        ),
      ),
    );
  }

  selectSex(selected) {
    print(selected);
    print('xuanze xingbie');
    setState(() {
      sex = selected;
    });
  }

  goToHome() {
    if (sex == 0 || sex == 1) {
      SharedPres.setInt('sex', sex);
    }
    Routes.router.navigateTo(context, '${Routes.home}', clearStack: true);
  }
}