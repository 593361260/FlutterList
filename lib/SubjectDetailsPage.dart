import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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
                ListView()
              ],
            )
          : {
              getDetails(id),
              Container(
                width: double.infinity,
                height: 214,
                child: Image(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.fitWidth,
                ),
              )
            },
    );
  }

  getDetails(String id) async {
    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse('http://api.ring.51app.cn/r/specialList/$id.do'));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var list = json.decode(responseBody)["body"];
    setState(() {
      body = list;
    });
  }
}
