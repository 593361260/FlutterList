import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_list/SubjectDetailsPage.dart';

class RecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendBuilder();
  }
}

class _RecommendBuilder extends State<RecommendWidget>
    with AutomaticKeepAliveClientMixin {
  List data;
  var _scroller = new ScrollController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: RefreshIndicator(
          child: new ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: data == null ? _loading() : _getItem(),
            controller: _scroller,
          ),
          onRefresh: _refresh),
    ));
  }

  List<Widget> _loading() {
    getHttp(current);
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
        margin: EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
      );
    }).toList();
  }

  Widget _getRowItem(f) {
    return new GestureDetector(
      child: new Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(f['smallimageUrl']), fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          ),
          new Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(children: <Widget>[
              Container(
                child: Text(
                  f['name'],
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              ),
              Container(
                child: Text(
                  f['about'],
                  style: TextStyle(color: Color(0xff777777), fontSize: 12),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              ),
            ], crossAxisAlignment: CrossAxisAlignment.start),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return new SubjectDetailsPage(
              imgUrl: f["smallimageUrl"], id: f['id'].toString());
        }));
      },
    );
  }

  Future _refresh() async {
    data.clear();
    current = 0;
    getHttp(current);
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
      if (null == data) {
        data = list;
      } else {
        data.addAll(list);
      }
    });
    print('$responseBody');
  }

  @override
  void dispose() {
    super.dispose();
    _scroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scroller.addListener(() {
      if (_scroller.position.pixels == _scroller.position.maxScrollExtent) {
        current++;
        getHttp(current);
        print('加载更多');
      }
    });
    print('init RecommendWidget');
  }

  @override
  bool get wantKeepAlive => true;
}
