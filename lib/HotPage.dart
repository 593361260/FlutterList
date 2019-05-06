import 'package:flutter/material.dart';

/*
* 最热的界面
* */
class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotPageBuilder();
  }
}

class _HotPageBuilder extends State<HotPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Text('HotPage'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('init HotPage');
  }

  @override
  bool get wantKeepAlive => true;
}
