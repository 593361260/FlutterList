import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              getHttp();
            },
          )
        ],
      ),
      body: new ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: data == null ? null : _getItem(),
      ),
    );
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
  getHttp() async {
    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse('http://api.ring.51app.cn/r/special/0.do'));
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    var list = json.decode(responseBody)["body"];
    setState(() {
      data = list;
    });
    print('$responseBody');
  }
}
