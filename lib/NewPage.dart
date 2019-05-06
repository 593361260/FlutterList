import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Text('sortPage'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('init NewPageWidget');
  }

  @override
  bool get wantKeepAlive => true;
}
