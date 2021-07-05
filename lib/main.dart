import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "My app",
    home: Container(
      child: SafeArea(child: MyScaffold()),
      decoration: BoxDecoration(color: Colors.white),
    ),
  ));
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          MyAppBar(
            title: Text("Example title",
                style: Theme.of(context).primaryTextTheme.headline6),
          ),
          Expanded(
            child: Center(child: Text("Hello Flutter")),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  final Widget title;

  MyAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: [
          IconButton(onPressed: null, icon: Icon(Icons.menu)),
          Expanded(child: title),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
            tooltip: "Search",
          )
        ],
      ),
    );
  }
}
