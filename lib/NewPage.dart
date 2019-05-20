import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'PlayMenu.dart';

/*
 * 分类专题
 */
class NewPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewPageBuilder();
  }
}

class _NewPageBuilder extends State<NewPageWidget>
    with AutomaticKeepAliveClientMixin {
  List data;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data != null
          ? ListView(
              children: _getItem(),
            )
          : _getNullView(),
    );
  }

  Widget _getNullView() {
    getDetails(currentPage);
    return Center(
      child: Text('正在加載。。。'),
    );
  }

  List<Widget> _getItem() {
    return data.map((f) {
      return Card(
        child: _getItemView(f),
        margin: EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 2.5),
        elevation: 2,
      );
    }).toList();
  }

  Widget _getItemView(f) {
    return new GestureDetector(
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(f['imageUrl']), fit: BoxFit.cover)),
          ),
          new Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(children: <Widget>[
              Container(
                child: Text(
                  f['name'] + '-' + f['singer'],
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),
              Container(
                child: Text(
                  f['duration'] + '-' + f['size'] + '-' + f['count'],
                  style: TextStyle(color: Color(0xff777777), fontSize: 11),
                ),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              ),
            ], crossAxisAlignment: CrossAxisAlignment.start),
          )
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
          return new play_menu_widget(
            imgUrl: f['imageUrl'],
            playUrl: f['auditionUrl'],
          );
        }));
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  getDetails(int id) async {
    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse('http://api.ring.51app.cn/r/newTopic/$id.do'));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    print('$response');
    var list = json.decode(responseBody)["body"];
    setState(() {
      data = list;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
