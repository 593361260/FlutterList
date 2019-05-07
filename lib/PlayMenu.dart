import 'package:flutter/material.dart';

/*
* 播放的界面
* */
class play_menu_widget extends StatefulWidget {
  String imgUrl;
  String id;
  String playUrl;
  String info;

  play_menu_widget({Key key, this.id, this.imgUrl, this.info, this.playUrl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayMenuBuilder();
  }
}

class _PlayMenuBuilder extends State<play_menu_widget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child: RotationTransition(
        child: ClipOval(
          child: Image(
            image: NetworkImage(
                "http://img.ring.51app.cn/20190329/42635586d11843619149799c6f5b8b1a.png"),
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        ),
        turns: new CurvedAnimation(
            parent: new AnimationController(
                duration: const Duration(milliseconds: 2000),
                vsync: new AnimatedListState()),
            curve: Curves.easeIn),
      )),
    );
  }
}
