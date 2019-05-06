import 'package:flutter/material.dart';
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
  int _currentIndex = 0;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
//    getHttp();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        children: <Widget>[RecommendWidget(), HotPage(), NewPageWidget()],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
              )),
        ],
        onTap: (index) {
          pageController.jumpToPage(index);
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
