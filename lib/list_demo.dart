import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

class ListDemo extends StatefulWidget {
  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  List<int> datas = List.generate(42, (index) => Random.secure().nextInt(100));
  final _scrollableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        title: Text(
          "Title",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    key: _scrollableKey,
                    delegate: SliverChildListDelegate([
                      for (final entry in enumerate(datas))
                        _Tile(
                          title:
                              Text("Item: ${entry.index} value ${entry.value}"),
                        ),
                    ]),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    final ctx = _scrollableKey.currentContext;
                    if (ctx != null) {
                      Scrollable.of(ctx)?.position.animateTo(
                            0,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                    }
                  },
                  child: Text("ToBottom"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  final Widget title;

  _Tile({
    required this.title,
  }) : super();

  @override
  __TileState createState() => __TileState();
}

class __TileState extends State<_Tile> {
  @override
  void initState() {
    super.initState();
    print("Init");
  }

  @override
  void dispose() {
    print("Disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(title: widget.title);
  }
}
