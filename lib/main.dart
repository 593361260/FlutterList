import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_list/RecommendPage.dart';
import 'package:flutter_list/HotPage.dart';
import 'package:flutter_list/NewPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'music player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;
  int _currentIndex = 0;
  var titles = ["xixi", "haha", "lala"];

  @override
  Widget build(BuildContext context) {
//    getHttp();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              getHttp(0);
            },
          )
        ],
      ),
      /*body: Container(
            child: RefreshIndicator(
                child: new ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: data == null ? _loading() : _getItem(),
                ),
                onRefresh: _refresh)
        )*/
      body: IndexedStack(//这样可以保存widget的状态,但是所有界面都会被初始加载app时, 都被初始化
        index: _currentIndex,
        children: <Widget>[
          RecommendWidget(),
          HotPage(),
          NewPageWidget()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text("专题"),
              icon: Icon(Icons.cloud),
              activeIcon: Icon(Icons.cloud_circle)),
          BottomNavigationBarItem(
              title: Text("最热"),
              icon: Icon(Icons.cloud_queue),
              activeIcon: Icon(Icons.cloud_off)),
          BottomNavigationBarItem(
              title: Text("最新"),
              icon: Icon(Icons.brightness_1),
              activeIcon: Icon(
                Icons.brightness_4,
                color: Colors.amberAccent,
              )),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
    );
  }

  Future _refresh() async {
    data.clear();
    getHttp(0);
    return;
  }

  List<Widget> _loading() {
    getHttp(0);
    return <Widget>[
      new Center(
        child: Text('正在加載'),
      )
    ];
  }

  List<Widget> _getItem() {
    return data.map((f) {
      return Card(
        elevation: 2,
        child: _getRowItem(f),
        margin: EdgeInsets.all(10),
      );
    }).toList();
  }

  Widget _getRowItem(f) {
    return new Row(children: <Widget>[
      Image(width: 100, height: 100, image: NetworkImage(f['smallimageUrl'])),
      Text(f['name']),
    ]);
  }

//http://api.ring.51app.cn/r/special/0.do
  getHttp(int flag) async {
    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse('http://api.ring.51app.cn/r/special/$flag.do'));
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    var list = json.decode(responseBody)["body"];
    setState(() {
      data = list;
    });
    print('$responseBody');
  }
}
