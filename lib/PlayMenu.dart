import 'package:flutter/material.dart';

/*
* 播放的界面
* */
class PlayMenuWidget extends StatefulWidget {
  String imgUrl;
  String id;
  String playUrl;
  String info;

  PlayMenuWidget({Key key, this.id, this.imgUrl, this.info, this.playUrl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayMenuBuilder();
  }
}

class _PlayMenuBuilder extends State<PlayMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
    );
  }
}
