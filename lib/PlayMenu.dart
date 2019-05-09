import 'package:audioplayers/audioplayers.dart';
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
    return _PlayMenuBuilder(imgUrl, playUrl);
  }
}

class _PlayMenuBuilder extends State<play_menu_widget> {
  String imgUrl;
  String playUrl;
  AudioPlayer player = AudioPlayer();

  _PlayMenuBuilder(this.imgUrl, this.playUrl);

  @override
  Widget build(BuildContext context) {
    player.play(playUrl);
    return new Scaffold(
      body: Center(
          child: RotationTransition(
        child: ClipOval(
          child: Image(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        ),
        turns: new CurvedAnimation(
          parent: new AnimationController(
              duration: const Duration(milliseconds: 2000),
              vsync: new AnimatedListState()),
          curve: Curves.easeIn,
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }
}
