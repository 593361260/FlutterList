import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

class RecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendBuilder();
  }
}

class _RecommendBuilder extends State<RecommendWidget> with AutomaticKeepAliveClientMixin {
  List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: RefreshIndicator(
          child: new ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: data == null ? _loading() : _getItem(),
          ),
          onRefresh: _refresh),
    ));
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
        margin: EdgeInsets.fromLTRB(2.5,0,2.5,2.5),
      );
    }).toList();
  }

  Widget _getRowItem(f) {
    return new Row(children: <Widget>[
      Image(width: 100, height: 100, image: NetworkImage(f['smallimageUrl'])),
      Text(f['name']),
    ]);
  }

  Future _refresh() async {
    data.clear();
    getHttp(0);
    return;
  }

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

  @override
  bool get wantKeepAlive => true;
}
