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
      body: Column(
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
                turns: new CurvedAnimation(
                  parent: new AnimationController(
                      duration: const Duration(milliseconds: 2000),
                      vsync: new AnimatedListState()),
                  curve: Curves.easeIn,
                ),
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          ),
          Padding(
            child: Row(
              children: <Widget>[
                GestureDetector(child:
                Icon(
                  Icons.pause,
                ),
                onTap: (){
                  if(player.state==AudioPlayerState.PLAYING){//正在播放
                    player.pause();
                  }else{
                    if(player.state==AudioPlayerState.PAUSED) {
                      player.resume();
                    }else if (player.state==AudioPlayerState.COMPLETED){
                      player.play(playUrl);
                    }else{

                    }
                  }
                },
                )
                ,
                Flexible(
                  child: Container(
                    child: Slider(
                        min: 0, max: 2000, value: 100, onChanged: (value) {
//                          player.
                      print('change value $value');
                    }),
                  ),
                  flex: 1,
                  fit: FlexFit.tight,
                ),
                Icon(Icons.play_arrow),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }
}
