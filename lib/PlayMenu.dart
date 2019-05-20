import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'TimeTools.dart';

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
    return new Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: Center(
                    child: RotationTransition(
                      child: ClipOval(
                        child: Image(
                          image: NetworkImage(imgUrl),
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      turns: new Tween<double>(begin: 0.0, end: 1.0)
                          .animate(_controller),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                ),
                Container(
                  child: Image(
                    image: AssetImage('icon/play_needle.png'),
                    width: 92,
                    height: 138,
                  ),
                  margin: EdgeInsets.fromLTRB(46, 0, 0, 0),
                  alignment: Alignment.center,
                )
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.pause,
                  ),
                  onTap: () {
                    if (player.state == AudioPlayerState.PLAYING) {
                      //正在播放
                      player.pause();
                    } else {
                      if (player.state == AudioPlayerState.PAUSED) {
                        player.resume();
                      } else if (player.state == AudioPlayerState.COMPLETED) {
                        player.play(playUrl);
                      } else {}
                    }
                  },
                ),
                Icon(Icons.play_arrow),
              ],
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    TimeParse.parse(currentPosition),
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 15,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: Slider(
                          min: 0,
                          max: 2000,
                          value: position.toDouble(),
                          onChanged: (value) {
                            print('change value $value');
                          }),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    flex: 1,
                    fit: FlexFit.tight,
                  ),
                  Text(
                    TimeParse.parse(allDuration),
                    style: TextStyle(color: Color(0xff999999), fontSize: 15),
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(15, 100, 15, 0),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Opacity(
            child: Image(image: NetworkImage(imgUrl)),
            opacity: 0.6,
          ),
        )
      ],
    );
  }

  Animation<double> animation_record;
  AnimationController _controller;
  int position = 0;
  int allDuration = 0;
  int currentPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 20000),
        vsync: new AnimatedListState());
    animation_record =
        new CurvedAnimation(parent: _controller, curve: Curves.linear);

    animation_record.addStatusListener((state) {
      print('动画播放的状态  $state');
      if (state == AnimationStatus.completed) {
        if (player.state == AudioPlayerState.PLAYING) {
          _controller.forward();
        }
      }
    });
    //播放状态的监听
    player.onPlayerStateChanged.listen((data) {
      if (data == AudioPlayerState.PLAYING) {
        _controller.forward();
      } else if (data == AudioPlayerState.COMPLETED) {
        _controller.stop();
      } else if (data == AudioPlayerState.PAUSED) {
        _controller.stop();
      } else if (data == AudioPlayerState.STOPPED) {
        _controller.stop();
      }
      print('bofang  完成$data');
    });
    player.onDurationChanged.listen((duration) {
      setState(() {
        allDuration = duration.inSeconds;
      });
//      print(' 播放进度 ${duration.inSeconds}  ${duration.inMilliseconds}  ${duration.inMicroseconds}');
    });

    player.onAudioPositionChanged.listen((onData) {
      /**
       * 更换当前进度条
       */
      setState(() {
        currentPosition = onData.inSeconds;
        if (allDuration != 0) {
          position =
              (onData.inSeconds.toDouble() / allDuration.toDouble() * 2000)
                  .toInt();
        }
      });
      print('${onData.inSeconds}  ');
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }
}
