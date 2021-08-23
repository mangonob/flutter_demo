import 'package:flutter/material.dart';
import 'package:flutter_demo/tabber.dart';

class TabberDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        title: Text(
          "Tabber",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Tabber(topSlivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      height: 100,
                      color: Colors.blue,
                    ),
                    Container(
                      height: 100,
                      color: Colors.green,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
