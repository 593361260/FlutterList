import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_list/PlayMenu.dart';

class SubjectDetailsPage extends StatefulWidget {
  String id;
  String imgUrl;

  SubjectDetailsPage({Key key, this.imgUrl, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectDetailsBuilder(id, imgUrl);
  }
}

class _SubjectDetailsBuilder extends State<SubjectDetailsPage> {
  String id;
  String imgUrl;
  var body;

  _SubjectDetailsBuilder(this.id, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: body != null
          ? new Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 214,
                  child: Image(
                    image: NetworkImage(body['bigimageUrl']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ListView(
                    children: _getItem(),
                  ),
                )
              ],
            )
          : getView(),
    );
  }

  List<Widget> _getItem() {
    List data = body['ringtones'];
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
          return new play_menu_widget(imgUrl: f['imageUrl']);
        }));
      },
    );
  }

  Widget getView() {
    getDetails(id);
    return Container(
      width: double.infinity,
      height: 214,
      child: Image(
        image: NetworkImage(imgUrl),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  getDetails(String id) async {
    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse('http://api.ring.51app.cn/r/specialList/$id.do'));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    print('$response');
    var list = json.decode(responseBody)["body"];
    setState(() {
      body = list;
    });
  }
}
